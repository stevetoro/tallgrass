import decode
import tallgrass/client.{type Client}
import tallgrass/common/name.{type Name, name}
import tallgrass/common/resource.{type Resource, resource}

pub type MoveAilment {
  MoveAilment(id: Int, name: String, moves: List(Resource), names: List(Name))
}

const path = "move-ailment"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of move ailment resources.
///
/// # Example
///
/// ```gleam
/// let result = ailment.new() |> ailment.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches a move ailment given a move ailment resource.
///
/// # Example
///
/// ```gleam
/// let client = ailment.new()
/// use res <- result.try(client |> ailment.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> ailment.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, move_ailment())
}

/// Fetches a move ailment given the move ailment ID.
///
/// # Example
///
/// ```gleam
/// let result = ailment.new() |> ailment.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, move_ailment())
}

/// Fetches a move ailment given the move ailment name.
///
/// # Example
///
/// ```gleam
/// let result = ailment.new() |> ailment.fetch_by_name("paralysis")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  client.fetch_by_name(client, path, name, move_ailment())
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
