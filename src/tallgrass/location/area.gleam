import decode
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

/// Fetches a location_area by the location_area ID.
///
/// # Example
///
/// ```gleam
/// let result = area.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, location_area())
}

/// Fetches a location_area by the location_area name.
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
