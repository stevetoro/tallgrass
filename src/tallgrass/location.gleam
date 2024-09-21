import decode
import tallgrass/common/generation.{
  type GenerationGameIndex, generation_game_index,
}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

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

/// Fetches a location by the location ID.
///
/// # Example
///
/// ```gleam
/// let result = location.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, location())
}

/// Fetches a location by the location name.
///
/// # Example
///
/// ```gleam
/// let result = location.fetch_by_name("canalave-city")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, location())
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
