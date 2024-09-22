import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type MoveAilment {
  MoveAilment(id: Int, name: String, moves: List(Resource), names: List(Name))
}

const path = "move-ailment"

/// Fetches a list of move ailment resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = ailment.fetch(options: Default)
/// let result = ailment.fetch(options: Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options options: PaginationOptions, cache cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a move ailment given a move ailment resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(ailment.fetch(options: Default))
/// let assert Ok(first) = res.results |> list.first
/// ailment.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, using: move_ailment(), cache: cache)
}

/// Fetches a move ailment given the move ailment ID.
///
/// # Example
///
/// ```gleam
/// let result = ailment.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, move_ailment(), cache: cache)
}

/// Fetches a move ailment given the move ailment name.
///
/// # Example
///
/// ```gleam
/// let result = ailment.fetch_by_name("paralysis")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, move_ailment(), cache: cache)
}

fn move_ailment() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use moves <- decode.parameter
    use names <- decode.parameter
    MoveAilment(id, name, moves, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("moves", decode.list(of: resource()))
  |> decode.field("names", decode.list(of: name()))
}
