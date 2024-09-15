import decode
import tallgrass/fetch
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}
import tallgrass/internal/common/effect.{type Effect, effect}
import tallgrass/internal/common/flavor_text.{
  type FlavorTextWithVersionGroup, flavor_text_with_version_group,
}
import tallgrass/internal/common/name.{type Name, Name, name}
import tallgrass/internal/common/pokemon.{
  type PokemonWithHidden, PokemonWithHidden, pokemon_with_hidden,
}

pub type Ability {
  Ability(
    id: Int,
    name: String,
    is_main_series: Bool,
    generation: Affordance,
    names: List(Name),
    effect_entries: List(Effect),
    flavor_text_entries: List(FlavorTextWithVersionGroup),
    pokemon: List(PokemonWithHidden),
  )
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
  fetch.resource_by_id(id, path, ability())
}

/// Fetches a pokemon ability by the ability name.
///
/// # Example
///
/// ```gleam
/// let result = ability.fetch_by_name("serene-grace")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, ability())
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
  |> decode.field("generation", affordance())
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("effect_entries", decode.list(of: effect()))
  |> decode.field(
    "flavor_text_entries",
    decode.list(of: flavor_text_with_version_group(field: "flavor_text")),
  )
  |> decode.field("pokemon", decode.list(of: pokemon_with_hidden()))
}
