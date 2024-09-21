import decode
import tallgrass/common/effect.{type VerboseEffect, verbose_effect}
import tallgrass/common/flavor_text.{
  type FlavorTextVersionGroup, flavor_text_version_group,
}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

pub type Ability {
  Ability(
    id: Int,
    name: String,
    is_main_series: Bool,
    generation: Resource,
    names: List(Name),
    effect_entries: List(VerboseEffect),
    flavor_text_entries: List(FlavorTextVersionGroup),
    pokemon: List(AbilityPokemon),
  )
}

pub type AbilityPokemon {
  AbilityPokemon(is_hidden: Bool, slot: Int, pokemon: Resource)
}

const path = "ability"

/// Fetches a pokemon ability by the ability ID.
///
/// # Example
///
/// ```gleam
/// let result = ability.fetch_by_id(32)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, ability())
}

/// Fetches a pokemon ability by the ability name.
///
/// # Example
///
/// ```gleam
/// let result = ability.fetch_by_name("serene-grace")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, ability())
}

fn ability() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use is_main_series <- decode.parameter
    use generation <- decode.parameter
    use names <- decode.parameter
    use effect_entries <- decode.parameter
    use flavor_texts <- decode.parameter
    use pokemon <- decode.parameter
    Ability(
      id,
      name,
      is_main_series,
      generation,
      names,
      effect_entries,
      flavor_texts,
      pokemon,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("is_main_series", decode.bool)
  |> decode.field("generation", resource())
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("effect_entries", decode.list(of: verbose_effect()))
  |> decode.field(
    "flavor_text_entries",
    decode.list(of: flavor_text_version_group()),
  )
  |> decode.field("pokemon", decode.list(of: ability_pokemon()))
}

fn ability_pokemon() {
  decode.into({
    use is_hidden <- decode.parameter
    use slot <- decode.parameter
    use pokemon <- decode.parameter
    AbilityPokemon(is_hidden, slot, pokemon)
  })
  |> decode.field("is_hidden", decode.bool)
  |> decode.field("slot", decode.int)
  |> decode.field("pokemon", resource())
}
