import decode
import gleam/option.{type Option}
import tallgrass/client.{type Client}
import tallgrass/client/resource.{type Resource, resource}
import tallgrass/common/effect.{type VerboseEffect, verbose_effect}
import tallgrass/common/flavor_text.{
  type FlavorTextVersionGroup, flavor_text_version_group,
}
import tallgrass/common/name.{type Name, name}

pub type Move {
  Move(
    id: Int,
    name: String,
    accuracy: Int,
    effect_chance: Option(Int),
    pp: Int,
    priority: Int,
    power: Int,
    contest_type: Resource,
    contest_effect: Resource,
    damage_class: Resource,
    effect_entries: List(VerboseEffect),
    generation: Resource,
    names: List(Name),
    super_contest_effect: Resource,
    target: Resource,
    pokemon_type: Resource,
    learned_by_pokemon: List(Resource),
    flavor_text_entries: List(FlavorTextVersionGroup),
  )
}

const path = "move"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of move resources.
///
/// # Example
///
/// ```gleam
/// let result = move.new() |> move.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches a move given a move resource.
///
/// # Example
///
/// ```gleam
/// let client = move.new()
/// use res <- result.try(client |> move.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> move.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, move())
}

/// Fetches a move given the move ID.
///
/// # Example
///
/// ```gleam
/// let result = move.new() |> move.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, move())
}

/// Fetches a move given the move name.
///
/// # Example
///
/// ```gleam
/// let result = move.new() |> move.fetch_by_name("pound")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, move())
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
  |> decode.field("contest_type", resource())
  |> decode.field("contest_effect", resource())
  |> decode.field("damage_class", resource())
  |> decode.field("effect_entries", decode.list(of: verbose_effect()))
  |> decode.field("generation", resource())
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("super_contest_effect", resource())
  |> decode.field("target", resource())
  |> decode.field("type", resource())
  |> decode.field("learned_by_pokemon", decode.list(of: resource()))
  |> decode.field(
    "flavor_text_entries",
    decode.list(of: flavor_text_version_group()),
  )
}
