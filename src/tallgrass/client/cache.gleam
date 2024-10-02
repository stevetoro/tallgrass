//// Basic request caching based on Erlang Term Storage (ETS).

import carpenter/table.{type Set}
import gleam/erlang/process.{type Subject}
import gleam/otp/actor

/// A ready-to-use cache can be initialized by using the `new` function.
///
/// # Example
///
/// ```gleam
/// let assert Ok(cache) = cache.new("my-unique-name")
/// let client = client.new() |> with_cache(cache)
/// client |> pokemon.fetch()
/// ```
pub opaque type Cache {
  Cache(Set(String, String), fn() -> Nil)
}

/// Specifies how often the cache should be expired in seconds, minutes, or hours.
pub type CacheExpiry {
  Seconds(Int)
  Minutes(Int)
  Hours(Int)
}

type CacheFlusherMessage {
  StartCacheFlusher(Subject(CacheFlusherMessage))
  RunCacheFlusher(Subject(CacheFlusherMessage))
  StopCacheFlusher
}

type CacheFlusherState {
  CacheFlusherState(table: Set(String, String), interval: Int)
}

@internal
pub type Error {
  NewCacheError
  NotFound
}

/// Initializes a cache that can be passed to client.with_cache()
/// If multiple caches are initialized, the `name` param should be unique in order to avoid ETS runtime errors.
pub fn new(name: String, expiry: CacheExpiry) {
  case table(name) {
    Ok(table) -> {
      let flusher = table |> start_flusher(expiry)
      let stop = fn() { actor.send(flusher, StopCacheFlusher) }
      Ok(Cache(table, stop))
    }
    _ -> Error(NewCacheError)
  }
}

/// Shuts down the cache and cache flushing process.
/// Care should be taken to not pass a shutdown cache to client.with_cache.
pub fn shutdown(cache: Cache) {
  let Cache(_, stop_cache_flusher) = cache
  stop_cache_flusher()
}

@internal
pub fn contains(cache: Cache, req: String) {
  let Cache(table, _) = cache
  table |> table.contains(req)
}

@internal
pub fn lookup(cache: Cache, req: String) {
  case cache |> contains(req) {
    False -> Error(NotFound)
    True -> {
      let Cache(table, _) = cache
      let assert [tup, ..] = table |> table.lookup(req)
      Ok(tup.1)
    }
  }
}

@internal
pub fn insert(cache: Cache, req: String, res: String) {
  let Cache(table, _) = cache
  table |> table.insert([#(req, res)])
}

fn table(name: String) {
  table.build(name)
  |> table.privacy(table.Public)
  |> table.write_concurrency(table.AutoWriteConcurrency)
  |> table.read_concurrency(True)
  |> table.decentralized_counters(True)
  |> table.compression(False)
  |> table.set
}

fn start_flusher(table: Set(String, String), expiry: CacheExpiry) {
  let expire = case expiry {
    Hours(hours) -> 1000 * 60 * 60 * hours
    Minutes(minutes) -> 1000 * 60 * minutes
    Seconds(seconds) -> 1000 * seconds
  }
  let assert Ok(flusher) =
    actor.start(CacheFlusherState(table, expire), handle_flusher_message)
  actor.send(flusher, StartCacheFlusher(flusher))
  flusher
}

fn handle_flusher_message(
  message: CacheFlusherMessage,
  state: CacheFlusherState,
) {
  case message {
    StartCacheFlusher(subject) -> {
      process.send_after(subject, state.interval, RunCacheFlusher(subject))
      actor.continue(state)
    }
    RunCacheFlusher(subject) -> {
      state.table |> table.delete_all
      process.send_after(subject, state.interval, RunCacheFlusher(subject))
      actor.continue(state)
    }
    StopCacheFlusher -> {
      state.table |> table.drop
      actor.Stop(process.Normal)
    }
  }
}
