import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/description.{type Description, description}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type MoveCategory {
  MoveCategory(
    id: Int,
    name: String,
    descriptions: List(Description),
    moves: List(Resource),
  )
}

const path = "move-category"

/// Fetches a list of move category resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = category.fetch(DefaultPagination)
/// let result = category.fetch(Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a move category given a move category resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(category.fetch(DefaultPagination))
/// let assert Ok(first) = res.results |> list.first
/// category.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, move_category(), cache)
}

/// Fetches a move category given the move category ID.
///
/// # Example
///
/// ```gleam
/// let result = category.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, move_category(), cache)
}

/// Fetches a move category given the move category name.
///
/// # Example
///
/// ```gleam
/// let result = category.fetch_by_name("ailment")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, move_category(), cache)
}

fn move_category() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use descriptions <- decode.parameter
    use moves <- decode.parameter
    MoveCategory(id, name, descriptions, moves)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("descriptions", decode.list(of: description()))
  |> decode.field("moves", decode.list(of: resource()))
}
