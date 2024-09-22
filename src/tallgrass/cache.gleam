//// Basic request caching based on Erlang Term Storage (ETS).

import carpenter/table.{type Set}

/// A ready-to-use cache can be initialized by using the `new` function.
/// Use the `NoCache` constructor to signal that an API call shouldn't use a cache.
///
/// # Example
///
/// ```gleam
/// // will not use cache at all
/// pokemon.fetch(DefaultPagination, NoCache)
///
/// // will check cache prior to call and cache response if not found
/// let assert Ok(cache) = cache.new("my-unique-name")
/// pokemon.fetch(DefaultPagination, cache)
/// ```
pub type Cache {
  Cache(Set(String, String))
  NoCache
}

@internal
pub type Error {
  NewCacheError
  NotFound
}

/// Initializes a cache that can be passed to fetch functions.
/// If multiple caches are initialized, the `name` param should be unique in order to avoid ETS runtime errors.
pub fn new(name: String) {
  case table(name) {
    Ok(table) -> Ok(Cache(table))
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
  |> table.privacy(table.Private)
  |> table.write_concurrency(table.AutoWriteConcurrency)
  |> table.read_concurrency(True)
  |> table.decentralized_counters(True)
  |> table.compression(False)
  |> table.set
}
