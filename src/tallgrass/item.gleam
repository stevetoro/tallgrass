import decode
import gleam/option.{type Option}
import tallgrass/common/effect.{type VerboseEffect, verbose_effect}
import tallgrass/common/generation.{
  type GenerationGameIndex, generation_game_index,
}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type Item {
  Item(
    id: Int,
    name: String,
    cost: Int,
    fling_power: Option(Int),
    fling_effect: Option(Resource),
    attributes: List(Resource),
    category: Resource,
    effect_entries: List(VerboseEffect),
    flavor_text_entries: List(VersionGroupFlavorText),
    game_indices: List(GenerationGameIndex),
    names: List(Name),
    held_by_pokemon: List(ItemHolderPokemon),
    baby_trigger_for: Option(Resource),
  )
}

pub type VersionGroupFlavorText {
  VersionGroupFlavorText(
    text: String,
    language: Resource,
    version_group: Resource,
  )
}

pub type ItemHolderPokemon {
  ItemHolderPokemon(
    pokemon: Resource,
    version_details: List(ItemHolderPokemonVersionDetail),
  )
}

pub type ItemHolderPokemonVersionDetail {
  ItemHolderPokemonVersionDetail(rarity: Int, version: Resource)
}

const path = "item"

/// Fetches a list of item resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = item.fetch(options: None)
/// let result = item.fetch(options: Some(PaginationOptions(limit: 100, offset: 0)))
/// ```
pub fn fetch(options options: Option(PaginationOptions)) {
  resource.fetch_resources(path, options)
}

/// Fetches an item given an item resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(item.fetch(options: None))
/// let assert Ok(first) = res.results |> list.first
/// item.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: item())
}

/// Fetches an item given the item ID.
///
/// # Example
///
/// ```gleam
/// let result = item.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, item())
}

/// Fetches a item given the item name.
///
/// # Example
///
/// ```gleam
/// let result = item.fetch_by_name("master-ball")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, item())
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
  |> decode.field("fling_effect", decode.optional(resource()))
  |> decode.field("attributes", decode.list(of: resource()))
  |> decode.field("category", resource())
  |> decode.field("effect_entries", decode.list(of: verbose_effect()))
  |> decode.field(
    "flavor_text_entries",
    decode.list(of: version_group_flavor_text()),
  )
  |> decode.field("game_indices", decode.list(of: generation_game_index()))
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("held_by_pokemon", decode.list(of: item_holder_pokemon()))
  |> decode.field("baby_trigger_for", decode.optional(resource()))
}

fn version_group_flavor_text() {
  decode.into({
    use text <- decode.parameter
    use language <- decode.parameter
    use version_group <- decode.parameter
    VersionGroupFlavorText(text, language, version_group)
  })
  |> decode.field("text", decode.string)
  |> decode.field("language", resource())
  |> decode.field("version_group", resource())
}

fn item_holder_pokemon() {
  decode.into({
    use pokemon <- decode.parameter
    use version_details <- decode.parameter
    ItemHolderPokemon(pokemon, version_details)
  })
  |> decode.field("pokemon", resource())
  |> decode.field(
    "version_details",
    decode.list(of: item_holder_pokemon_version_detail()),
  )
}

fn item_holder_pokemon_version_detail() {
  decode.into({
    use rarity <- decode.parameter
    use version <- decode.parameter
    ItemHolderPokemonVersionDetail(rarity, version)
  })
  |> decode.field("rarity", decode.int)
  |> decode.field("version", resource())
}
