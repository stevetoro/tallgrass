import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/name.{type Name, name}
import tallgrass/fetch

pub type Generation {
  Generation(
    id: Int,
    name: String,
    abilities: List(Affordance),
    main_region: Affordance,
    moves: List(Affordance),
    names: List(Name),
    pokemon_species: List(Affordance),
    types: List(Affordance),
    version_groups: List(Affordance),
  )
}

const path = "generation"

/// Fetches a generation by the generation ID.
///
/// # Example
///
/// ```gleam
/// let result = generation.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, generation())
}

/// Fetches a generation by the generation name.
///
/// # Example
///
/// ```gleam
/// let result = generation.fetch_by_name("generation-i")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, generation())
}

fn generation() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use abilities <- decode.parameter
    use main_region <- decode.parameter
    use moves <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    use types <- decode.parameter
    use version_groups <- decode.parameter
    Generation(
      id,
      name,
      abilities,
      main_region,
      moves,
      names,
      pokemon_species,
      types,
      version_groups,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("abilities", decode.list(of: affordance()))
  |> decode.field("main_region", affordance())
  |> decode.field("moves", decode.list(of: affordance()))
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: affordance()))
  |> decode.field("types", decode.list(of: affordance()))
  |> decode.field("version_groups", decode.list(of: affordance()))
}
