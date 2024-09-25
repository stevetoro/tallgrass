import decode
import tallgrass/client.{type Client}
import tallgrass/common/resource.{type Resource, resource}
import tallgrass/common/description.{type Description, description}

pub type MoveCategory {
  MoveCategory(
    id: Int,
    name: String,
    descriptions: List(Description),
    moves: List(Resource),
  )
}

const path = "move-category"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of move category resources.
///
/// # Example
///
/// ```gleam
/// let result = category.new() |> category.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches a move category given a move category resource.
///
/// # Example
///
/// ```gleam
/// let client = category.new()
/// use res <- result.try(client |> category.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> category.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, move_category())
}

/// Fetches a move category given the move category ID.
///
/// # Example
///
/// ```gleam
/// let result = category.new() |> category.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, move_category())
}

/// Fetches a move category given the move category name.
///
/// # Example
///
/// ```gleam
/// let result = category.new() |> category.fetch_by_name("ailment")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  client.fetch_by_name(client, path, name, move_category())
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
