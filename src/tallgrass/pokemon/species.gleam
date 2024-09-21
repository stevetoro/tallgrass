import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

pub type PokemonSpecies {
  PokemonSpecies(
    id: Int,
    name: String,
    order: Int,
    gender_rate: Int,
    capture_rate: Int,
    base_happiness: Int,
    is_baby: Bool,
    is_legendary: Bool,
    is_mythical: Bool,
    hatch_counter: Int,
    has_gender_differences: Bool,
    forms_switchable: Bool,
    growth_rate: Resource,
    egg_groups: List(Resource),
    color: Resource,
    shape: Resource,
    evolves_from_species: Resource,
    generation: Resource,
    names: List(Name),
  )
}

const path = "pokemon-species"

/// Fetches a pokemon species by the species ID.
///
/// # Example
///
/// ```gleam
/// let result = species.fetch_by_id(132)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, pokemon_species())
}

/// Fetches a pokemon species by the species name.
///
/// # Example
///
/// ```gleam
/// let result = species.fetch_by_name("ditto")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, pokemon_species())
}

fn pokemon_species() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use order <- decode.parameter
    use gender_rate <- decode.parameter
    use capture_rate <- decode.parameter
    use base_happiness <- decode.parameter
    use is_baby <- decode.parameter
    use is_legendary <- decode.parameter
    use is_mythical <- decode.parameter
    use hatch_counter <- decode.parameter
    use has_gender_differences <- decode.parameter
    use forms_switchable <- decode.parameter
    use growth_rate <- decode.parameter
    use egg_groups <- decode.parameter
    use color <- decode.parameter
    use shape <- decode.parameter
    use evolves_from_species <- decode.parameter
    use generation <- decode.parameter
    use names <- decode.parameter
    PokemonSpecies(
      id,
      name,
      order,
      gender_rate,
      capture_rate,
      base_happiness,
      is_baby,
      is_legendary,
      is_mythical,
      hatch_counter,
      has_gender_differences,
      forms_switchable,
      growth_rate,
      egg_groups,
      color,
      shape,
      evolves_from_species,
      generation,
      names,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("order", decode.int)
  |> decode.field("gender_rate", decode.int)
  |> decode.field("capture_rate", decode.int)
  |> decode.field("base_happiness", decode.int)
  |> decode.field("is_baby", decode.bool)
  |> decode.field("is_legendary", decode.bool)
  |> decode.field("is_mythical", decode.bool)
  |> decode.field("hatch_counter", decode.int)
  |> decode.field("has_gender_differences", decode.bool)
  |> decode.field("forms_switchable", decode.bool)
  |> decode.field("growth_rate", resource())
  |> decode.field("egg_groups", decode.list(of: resource()))
  |> decode.field("color", resource())
  |> decode.field("shape", resource())
  |> decode.field("evolves_from_species", resource())
  |> decode.field("generation", resource())
  |> decode.field("names", decode.list(of: name()))
}
