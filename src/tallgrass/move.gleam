import decode
import gleam/option.{type Option}
import tallgrass/common/effect.{type VerboseEffect, verbose_effect}
import tallgrass/common/flavor_text.{
  type FlavorTextVersionGroup, flavor_text_version_group,
}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{
  type NamedResource, type Resource, named_resource, resource,
}

pub type Move {
  Move(
    id: Int,
    name: String,
    accuracy: Int,
    effect_chance: Option(Int),
    pp: Int,
    priority: Int,
    power: Int,
    contest_type: NamedResource,
    contest_effect: Resource,
    damage_class: NamedResource,
    effect_entries: List(VerboseEffect),
    generation: NamedResource,
    names: List(Name),
    super_contest_effect: Resource,
    target: NamedResource,
    pokemon_type: NamedResource,
    learned_by_pokemon: List(NamedResource),
    flavor_text_entries: List(FlavorTextVersionGroup),
  )
}

const path = "move"

/// Fetches a move by the move ID.
///
/// # Example
///
/// ```gleam
/// let result = move.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, move())
}

/// Fetches a move by the move name.
///
/// # Example
///
/// ```gleam
/// let result = move.fetch_by_name("pound")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, move())
}

fn move() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use accuracy <- decode.parameter
    use effect_chance <- decode.parameter
    use pp <- decode.parameter
    use priority <- decode.parameter
    use power <- decode.parameter
    use contest_type <- decode.parameter
    use contest_effect <- decode.parameter
    use damage_class <- decode.parameter
    use effect_entries <- decode.parameter
    use generation <- decode.parameter
    use names <- decode.parameter
    use super_contest_effect <- decode.parameter
    use target <- decode.parameter
    use pokemon_type <- decode.parameter
    use learned_by_pokemon <- decode.parameter
    use flavor_text_entries <- decode.parameter
    Move(
      id,
      name,
      accuracy,
      effect_chance,
      pp,
      priority,
      power,
      contest_type,
      contest_effect,
      damage_class,
      effect_entries,
      generation,
      names,
      super_contest_effect,
      target,
      pokemon_type,
      learned_by_pokemon,
      flavor_text_entries,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("accuracy", decode.int)
  |> decode.field("effect_chance", decode.optional(decode.int))
  |> decode.field("pp", decode.int)
  |> decode.field("priority", decode.int)
  |> decode.field("power", decode.int)
  |> decode.field("contest_type", named_resource())
  |> decode.field("contest_effect", resource())
  |> decode.field("damage_class", named_resource())
  |> decode.field("effect_entries", decode.list(of: verbose_effect()))
  |> decode.field("generation", named_resource())
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("super_contest_effect", resource())
  |> decode.field("target", named_resource())
  |> decode.field("type", named_resource())
  |> decode.field("learned_by_pokemon", decode.list(of: named_resource()))
  |> decode.field(
    "flavor_text_entries",
    decode.list(of: flavor_text_version_group()),
  )
}
