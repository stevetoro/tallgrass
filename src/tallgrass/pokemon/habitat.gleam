import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type NamedResource, named_resource}

pub type Habitat {
  Habitat(
    id: Int,
    name: String,
    names: List(Name),
    pokemon_species: List(NamedResource),
  )
}

const path = "pokemon-habitat"

/// Fetches a pokemon habitat by the habitat ID.
///
/// # Example
///
/// ```gleam
/// let result = habitat.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, habitat())
}

/// Fetches a pokemon habitat by the habitat name.
///
/// # Example
///
/// ```gleam
/// let result = habitat.fetch_by_name("cave")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, habitat())
}

fn habitat() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    Habitat(id, name, names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: named_resource()))
}
