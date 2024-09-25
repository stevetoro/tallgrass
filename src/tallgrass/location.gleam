import decode
import tallgrass/client.{type Client}
import tallgrass/common/generation.{
  type GenerationGameIndex, generation_game_index,
}
import tallgrass/common/name.{type Name, name}
import tallgrass/client/resource.{type Resource, resource}

pub type Location {
  Location(
    id: Int,
    name: String,
    region: Resource,
    names: List(Name),
    game_indices: List(GenerationGameIndex),
    areas: List(Resource),
  )
}

const path = "location"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of location resources.
///
/// # Example
///
/// ```gleam
/// let result = location.new() |> location.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches a location given a location resource.
///
/// # Example
///
/// ```gleam
/// let client = location.new()
/// use res <- result.try(client |> location.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> location.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, location())
}

/// Fetches a location given the location ID.
///
/// # Example
///
/// ```gleam
/// let result = location.new() |> location.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, location())
}

/// Fetches a location given the location name.
///
/// # Example
///
/// ```gleam
/// let result = location.new() |> location.fetch_by_name("canalave-city")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, location())
}

fn location() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use region <- decode.parameter
    use names <- decode.parameter
    use game_indices <- decode.parameter
    use areas <- decode.parameter
    Location(id, name, region, names, game_indices, areas)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("region", resource())
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("game_indices", decode.list(of: generation_game_index()))
  |> decode.field("areas", decode.list(of: resource()))
}
