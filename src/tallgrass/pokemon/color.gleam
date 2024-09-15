import decode
import tallgrass/fetch
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}
import tallgrass/internal/common/name.{type Name, Name, name}

pub type Color {
  Color(
    id: Int,
    name: String,
    names: List(Name),
    pokemon_species: List(Affordance),
  )
}

const path = "pokemon-color"

/// Fetches a pokemon color by the color ID.
///
/// # Example
///
/// ```gleam
/// let result = color.fetch_by_id(9)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, color())
}

/// Fetches a pokemon color by the color name.
///
/// # Example
///
/// ```gleam
/// let result = color.fetch_by_name("white")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, color())
}

fn color() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    Color(id, name, names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: affordance()))
}
