import decode
import gleam/option.{type Option}
import tallgrass/fetch
import tallgrass/internal/common/affordance.{
  type Affordance, type URL, affordance, url,
}
import tallgrass/internal/common/effect.{type Effect, effect}
import tallgrass/internal/common/flavor_text.{
  type FlavorTextWithVersionGroup, flavor_text_with_version_group,
}
import tallgrass/internal/common/game_index.{
  type GameIndexGeneration, game_index_generation,
}
import tallgrass/internal/common/name.{type Name, name}
import tallgrass/internal/common/pokemon.{
  type PokemonWithVersionDetails, pokemon_version_details,
}

pub type Item {
  Item(
    id: Int,
    name: String,
    cost: Int,
    fling_power: Option(Int),
    fling_effect: Option(Affordance),
    attributes: List(Affordance),
    category: Affordance,
    effect_entries: List(Effect),
    flavor_text_entries: List(FlavorTextWithVersionGroup),
    game_indices: List(GameIndexGeneration),
    names: List(Name),
    held_by_pokemon: List(PokemonWithVersionDetails),
    baby_trigger_for: Option(URL),
  )
}

const path = "item"

/// Fetches a item by the item ID.
///
/// # Example
///
/// ```gleam
/// let result = item.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, item())
}

/// Fetches a item by the item name.
///
/// # Example
///
/// ```gleam
/// let result = item.fetch_by_name("master-ball")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, item())
}

fn item() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use cost <- decode.parameter
    use fling_power <- decode.parameter
    use fling_effect <- decode.parameter
    use attributes <- decode.parameter
    use category <- decode.parameter
    use effect_entries <- decode.parameter
    use flavor_text_entries <- decode.parameter
    use game_indices <- decode.parameter
    use names <- decode.parameter
    use held_by_pokemon <- decode.parameter
    use baby_trigger_for <- decode.parameter
    Item(
      id,
      name,
      cost,
      fling_power,
      fling_effect,
      attributes,
      category,
      effect_entries,
      flavor_text_entries,
      game_indices,
      names,
      held_by_pokemon,
      baby_trigger_for,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("cost", decode.int)
  |> decode.field("fling_power", decode.optional(decode.int))
  |> decode.field("fling_effect", decode.optional(affordance()))
  |> decode.field("attributes", decode.list(of: affordance()))
  |> decode.field("category", affordance())
  |> decode.field("effect_entries", decode.list(of: effect()))
  |> decode.field(
    "flavor_text_entries",
    decode.list(of: flavor_text_with_version_group(field: "text")),
  )
  |> decode.field("game_indices", decode.list(of: game_index_generation()))
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("held_by_pokemon", decode.list(of: pokemon_version_details()))
  |> decode.field("baby_trigger_for", decode.optional(url()))
}
