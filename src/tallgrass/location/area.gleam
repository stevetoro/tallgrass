import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

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

/// Fetches a list of location area resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = area.fetch(options: Default)
/// let result = area.fetch(options: Some(PaginationOptions(limit: 100, offset: 0)))
/// ```
pub fn fetch(options options: PaginationOptions) {
  resource.fetch_resources(path, options)
}

/// Fetches a location area given a location area resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(area.fetch(options: Default))
/// let assert Ok(first) = res.results |> list.first
/// area.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: location_area())
}

/// Fetches a location area given the location area ID.
///
/// # Example
///
/// ```gleam
/// let result = area.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, location_area())
}

/// Fetches a location area given the location area name.
///
/// # Example
///
/// ```gleam
/// let result = area.fetch_by_name("canalave-city-area")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, location_area())
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
