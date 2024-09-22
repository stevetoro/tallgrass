import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/description.{type Description, description}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type MoveTarget {
  MoveTarget(
    id: Int,
    name: String,
    descriptions: List(Description),
    moves: List(Resource),
    names: List(Name),
  )
}

const path = "move-target"

/// Fetches a list of move target resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = target.fetch(DefaultPagination, NoCache)
/// let result = target.fetch(Paginate(limit: 100, offset: 0), NoCache)
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a move target given a move target resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(target.fetch(DefaultPagination, NoCache))
/// let assert Ok(first) = res.results |> list.first
/// target.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, move_target(), cache)
}

/// Fetches a move target given the move target ID.
///
/// # Example
///
/// ```gleam
/// let result = target.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, move_target(), cache)
}

/// Fetches a move target given the move target name.
///
/// # Example
///
/// ```gleam
/// let result = target.fetch_by_name("specific-move")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, move_target(), cache)
}

fn move_target() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use descriptions <- decode.parameter
    use moves <- decode.parameter
    use names <- decode.parameter
    MoveTarget(id, name, descriptions, moves, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("descriptions", decode.list(of: description()))
  |> decode.field("moves", decode.list(of: resource()))
  |> decode.field("names", decode.list(of: name()))
}
