import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type NamedResource, named_resource}

pub type EvolutionTrigger {
  EvolutionTrigger(
    id: Int,
    name: String,
    names: List(Name),
    pokemon_species: List(NamedResource),
  )
}

const path = "evolution-trigger"

/// Fetches an evolution trigger by ID.
///
/// # Example
///
/// ```gleam
/// let result = evolution_trigger.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, evolution_trigger())
}

/// Fetches an evolution trigger by name.
///
/// # Example
///
/// ```gleam
/// let result = evolution_trigger.fetch_by_name("level-up")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, evolution_trigger())
}

fn evolution_trigger() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    EvolutionTrigger(id, name, names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: named_resource()))
}
