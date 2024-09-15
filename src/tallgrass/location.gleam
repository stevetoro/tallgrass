import decode
import tallgrass/fetch
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/game_index.{
  type GameIndexGeneration, game_index_generation,
}
import tallgrass/internal/common/name.{type Name, name}

pub type Location {
  Location(
    id: Int,
    name: String,
    region: Affordance,
    names: List(Name),
    game_indices: List(GameIndexGeneration),
    areas: List(Affordance),
  )
}

const path = "location"

/// Fetches a location by the location ID.
///
/// # Example
///
/// ```gleam
/// let result = location.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, location())
}

/// Fetches a location by the location name.
///
/// # Example
///
/// ```gleam
/// let result = location.fetch_by_name("canalave-city")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, location())
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
  |> decode.field("region", affordance())
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("game_indices", decode.list(of: game_index_generation()))
  |> decode.field("areas", decode.list(of: affordance()))
}
