import decode
import tallgrass/fetch
import tallgrass/internal/common/name.{type Name, name}

// TODO: Add support for pokemon_encounters.

pub type PalParkArea {
  PalParkArea(id: Int, name: String, names: List(Name))
}

const path = "pal-park-area"

/// Fetches a pal_park_area by the pal_park_area ID.
///
/// # Example
///
/// ```gleam
/// let result = pal_park_area.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, pal_park_area())
}

/// Fetches a pal_park_area by the pal_park_area name.
///
/// # Example
///
/// ```gleam
/// let result = pal_park_area.fetch_by_name("forest")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, pal_park_area())
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
