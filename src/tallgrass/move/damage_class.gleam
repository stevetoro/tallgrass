import decode
import tallgrass/client.{type Client}
import tallgrass/common/description.{type Description, description}
import tallgrass/common/name.{type Name, name}
import tallgrass/common/resource.{type Resource, resource}

pub type MoveDamageClass {
  MoveDamageClass(
    id: Int,
    name: String,
    descriptions: List(Description),
    moves: List(Resource),
    names: List(Name),
  )
}

const path = "move-damage-class"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of move damage class resources.
///
/// # Example
///
/// ```gleam
/// let result = damage_class.new() |> damage_class.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches a move damage class given a move damage class resource.
///
/// # Example
///
/// ```gleam
/// let client = damage_class.new()
/// use res <- result.try(client |> damage_class.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> damage_class.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, move_damage_class())
}

/// Fetches a move damage class given the move damage class ID.
///
/// # Example
///
/// ```gleam
/// let result = damage_class.new() |> damage_class.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, move_damage_class())
}

/// Fetches a move damage class given the move damage class name.
///
/// # Example
///
/// ```gleam
/// let result = damage_class.new() |> damage_class.fetch_by_name("status")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  client.fetch_by_name(client, path, name, move_damage_class())
}

fn move_damage_class() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use descriptions <- decode.parameter
    use moves <- decode.parameter
    use names <- decode.parameter
    MoveDamageClass(id, name, descriptions, moves, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("descriptions", decode.list(of: description()))
  |> decode.field("moves", decode.list(of: resource()))
  |> decode.field("names", decode.list(of: name()))
}
