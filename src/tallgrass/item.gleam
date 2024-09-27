import decode
import gleam/option.{type Option}
import tallgrass/client.{type Client}
import tallgrass/common/effect.{type VerboseEffect, verbose_effect}
import tallgrass/common/generation.{
  type GenerationGameIndex, generation_game_index,
}
import tallgrass/common/name.{type Name, name}
import tallgrass/common/resource.{type Resource, resource}

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
    machines: List(MachineVersionDetail),
    sprites: ItemSprites,
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

pub type MachineVersionDetail {
  MachineVersionDetail(machine: Resource, version_group: Resource)
}

pub type ItemSprites {
  ItemSprites(default: String)
}

const path = "item"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of item resources.
///
/// # Example
///
/// ```gleam
/// let result = item.new() |> item.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches an item given an item resource.
///
/// # Example
///
/// ```gleam
/// let client = client.new()
/// use res <- result.try(client |> item.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> item.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, item())
}

/// Fetches an item given the item ID.
///
/// # Example
///
/// ```gleam
/// let result = item.new() |> item.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, item())
}

/// Fetches an item given the item name.
///
/// # Example
///
/// ```gleam
/// let result = item.new() |> item.fetch_by_name("master-ball")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  client.fetch_by_name(client, path, name, item())
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
    use machines <- decode.parameter
    use sprites <- decode.parameter
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
      machines,
      sprites,
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
  |> decode.field("machines", decode.list(of: machine()))
  |> decode.field("sprites", item_sprites())
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

fn machine() {
  decode.into({
    use machine <- decode.parameter
    use version_group <- decode.parameter
    MachineVersionDetail(machine, version_group)
  })
  |> decode.field("machine", resource())
  |> decode.field("version_group", resource())
}

fn item_sprites() {
  decode.into({
    use default <- decode.parameter
    ItemSprites(default)
  })
  |> decode.field("default", decode.string)
}
