import decode
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
/// let result = category.fetch(options: Default)
/// let result = category.fetch(options: Some(PaginationOptions(limit: 100, offset: 0)))
/// ```
pub fn fetch(options options: PaginationOptions) {
  resource.fetch_resources(path, options)
}

/// Fetches a move category given a move category resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(category.fetch(options: Default))
/// let assert Ok(first) = res.results |> list.first
/// category.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: move_category())
}

/// Fetches a move category given the move category ID.
///
/// # Example
///
/// ```gleam
/// let result = category.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, move_category())
}

/// Fetches a move category given the move category name.
///
/// # Example
///
/// ```gleam
/// let result = category.fetch_by_name("ailment")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, move_category())
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
