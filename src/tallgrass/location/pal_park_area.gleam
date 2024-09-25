import decode
import tallgrass/client.{type Client}
import tallgrass/common/name.{type Name, name}
import tallgrass/common/resource.{type Resource}

// TODO: Add support for pokemon_encounters.

pub type PalParkArea {
  PalParkArea(id: Int, name: String, names: List(Name))
}

const path = "pal-park-area"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of pal park area resources.
///
/// # Example
///
/// ```gleam
/// let result = pal_park_area.new() |> pal_park_area.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches a pal park area given a pal park area resource.
///
/// # Example
///
/// ```gleam
/// let client = pal_park_area.new()
/// use res <- result.try(client |> pal_park_area.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> pal_park_area.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, pal_park_area())
}

/// Fetches a pal park area given the pal park area ID.
///
/// # Example
///
/// ```gleam
/// let result = pal_park_area.new() |> pal_park_area.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, pal_park_area())
}

/// Fetches a pal park area given the pal park area name.
///
/// # Example
///
/// ```gleam
/// let result = pal_park_area.new() |> pal_park_area.fetch_by_name("forest")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  client.fetch_by_name(client, path, name, pal_park_area())
}

fn pal_park_area() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    PalParkArea(id, name, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
}
