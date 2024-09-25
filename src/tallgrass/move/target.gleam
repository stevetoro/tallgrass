import decode
import tallgrass/client.{type Client}
import tallgrass/common/resource.{type Resource, resource}
import tallgrass/common/description.{type Description, description}
import tallgrass/common/name.{type Name, name}

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

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of move target resources.
///
/// # Example
///
/// ```gleam
/// let result = target.new() |> target.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches a move target given a move target resource.
///
/// # Example
///
/// ```gleam
/// let client = target.new()
/// use res <- result.try(client |> target.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> target.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, move_target())
}

/// Fetches a move target given the move target ID.
///
/// # Example
///
/// ```gleam
/// let result = target.new() |> target.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, move_target())
}

/// Fetches a move target given the move target name.
///
/// # Example
///
/// ```gleam
/// let result = target.new() |> target.fetch_by_name("specific-move")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  client.fetch_by_name(client, path, name, move_target())
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
