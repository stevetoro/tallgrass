import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type NamedResource, named_resource}

pub type PokemonColor {
  PokemonColor(
    id: Int,
    name: String,
    names: List(Name),
    pokemon_species: List(NamedResource),
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
  resource.fetch_by_id(id, path, pokemon_color())
}

/// Fetches a pokemon color by the color name.
///
/// # Example
///
/// ```gleam
/// let result = color.fetch_by_name("white")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, pokemon_color())
}

fn pokemon_color() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    PokemonColor(id, name, names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: named_resource()))
}
