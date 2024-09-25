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
pub type Cache {
  Cache(Set(String, String))
  NoCache
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
}

type CacheFlusherState {
  CacheFlusherState(cache: Cache, interval: Int)
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
      let cache = Cache(table)
      cache |> start_flusher(expiry)
      Ok(cache)
    }
    _ -> Error(NewCacheError)
  }
}

@internal
pub fn contains(cache: Cache, req: String) {
  let assert Cache(table) = cache
  table
  |> table.contains(req)
}

@internal
pub fn lookup(cache: Cache, req: String) {
  let assert Cache(table) = cache
  case cache |> contains(req) {
    False -> Error(NotFound)
    True -> {
      let assert [tup, ..] = table |> table.lookup(req)
      Ok(tup.1)
    }
  }
}

@internal
pub fn insert(cache: Cache, req: String, res: String) {
  let assert Cache(table) = cache
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

fn start_flusher(cache: Cache, expiry: CacheExpiry) {
  let expire = case expiry {
    Hours(hours) -> 1000 * 60 * 60 * hours
    Minutes(minutes) -> 1000 * 60 * minutes
    Seconds(seconds) -> 1000 * seconds
  }
  let assert Ok(flusher) =
    actor.start(CacheFlusherState(cache, expire), handle_flusher_message)
  actor.send(flusher, StartCacheFlusher(flusher))
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
      let assert Cache(table) = state.cache
      table |> table.delete_all
      process.send_after(subject, state.interval, RunCacheFlusher(subject))
      actor.continue(state)
    }
  }
}
