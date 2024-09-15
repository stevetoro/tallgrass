import decode
import tallgrass/fetch
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/name.{type Name, name}

// TODO: Add support for encounter_method_rates and pokemon_encounters.

pub type LocationArea {
  LocationArea(
    id: Int,
    name: String,
    game_index: Int,
    location: Affordance,
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
  fetch.resource_by_id(id, path, location_area())
}

/// Fetches a location_area by the location_area name.
///
/// # Example
///
/// ```gleam
/// let result = area.fetch_by_name("canalave-city-area")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, location_area())
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
  |> decode.field("location", affordance())
  |> decode.field("names", decode.list(of: name()))
}
