import carpenter/table.{type Set}

pub type Cache {
  Cache(Set(String, String))
  NoCache
}

pub type Error {
  NewCacheError
  NotFound
}

pub fn new() {
  case table() {
    Ok(table) -> Ok(Cache(table))
    _ -> Error(NewCacheError)
  }
}

pub fn contains(cache: Cache, req: String) {
  let assert Cache(table) = cache
  table
  |> table.contains(req)
}

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

pub fn insert(cache: Cache, req: String, res: String) {
  let assert Cache(table) = cache
  table |> table.insert([#(req, res)])
}

fn table() {
  table.build("tallgrass")
  |> table.privacy(table.Private)
  |> table.write_concurrency(table.AutoWriteConcurrency)
  |> table.read_concurrency(True)
  |> table.decentralized_counters(True)
  |> table.compression(False)
  |> table.set
}
