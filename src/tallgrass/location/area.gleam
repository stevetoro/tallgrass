import decode
import tallgrass/client.{type Client}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

// TODO: Add support for encounter_method_rates and pokemon_encounters.

pub type LocationArea {
  LocationArea(
    id: Int,
    name: String,
    game_index: Int,
    location: Resource,
    names: List(Name),
  )
}

const path = "location-area"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of location area resources.
///
/// # Example
///
/// ```gleam
/// let result = area.new() |> area.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.client_fetch_resources(client, path)
}

/// Fetches a location area given a location area resource.
///
/// # Example
///
/// ```gleam
/// let client = area.new()
/// use res <- result.try(client |> area.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> area.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.client_fetch_resource(client, resource, location_area())
}

/// Fetches a location area given the location area ID.
///
/// # Example
///
/// ```gleam
/// let result = area.new() |> area.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.client_fetch_by_id(client, path, id, location_area())
}

/// Fetches a location area given the location area name.
///
/// # Example
///
/// ```gleam
/// let result = area.new() |> area.fetch_by_name("canalave-city-area")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.client_fetch_by_name(client, path, name, location_area())
}

fn location_area() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use game_index <- decode.parameter
    use location <- decode.parameter
    use names <- decode.parameter
    LocationArea(id, name, game_index, location, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("game_index", decode.int)
  |> decode.field("location", resource())
  |> decode.field("names", decode.list(of: name()))
}
