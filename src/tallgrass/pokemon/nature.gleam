import decode
import gleam/option.{type Option}
import tallgrass/client.{type Client}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

pub type Nature {
  Nature(
    id: Int,
    name: String,
    decreased_stat: Option(Resource),
    increased_stat: Option(Resource),
    likes_flavor: Option(Resource),
    hates_flavor: Option(Resource),
    pokeathlon_stat_changes: List(NatureStatChange),
    move_battle_style_preferences: List(MoveBattleStylePreference),
    names: List(Name),
  )
}

pub type NatureStatChange {
  NatureStatChange(max_change: Int, pokeathlon_stat: Resource)
}

pub type MoveBattleStylePreference {
  MoveBattleStylePreference(
    low_hp_preference: Int,
    high_hp_preference: Int,
    move_battle_style: Resource,
  )
}

const path = "nature"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of pokemon nature resources.
///
/// # Example
///
/// ```gleam
/// let result = nature.new() |> nature.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.client_fetch_resources(client, path)
}

/// Fetches a pokemon nature given a pokemon nature resource.
///
/// # Example
///
/// ```gleam
/// let client = nature.new()
/// use res <- result.try(client |> nature.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> nature.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.client_fetch_resource(client, resource, nature())
}

/// Fetches a pokemon nature given the pokemon nature ID.
///
/// # Example
///
/// ```gleam
/// let result = nature.new() |> nature.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.client_fetch_by_id(client, path, id, nature())
}

/// Fetches a pokemon nature given the pokemon nature name.
///
/// # Example
///
/// ```gleam
/// let result = nature.new() |> nature.fetch_by_name("bold")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.client_fetch_by_name(client, path, name, nature())
}

fn nature() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use decreased_stat <- decode.parameter
    use increased_stat <- decode.parameter
    use likes_flavor <- decode.parameter
    use hates_flavor <- decode.parameter
    use pokeathlon_stat_changes <- decode.parameter
    use move_battle_style_preferences <- decode.parameter
    use names <- decode.parameter
    Nature(
      id,
      name,
      decreased_stat,
      increased_stat,
      likes_flavor,
      hates_flavor,
      pokeathlon_stat_changes,
      move_battle_style_preferences,
      names,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("decreased_stat", decode.optional(resource()))
  |> decode.field("increased_stat", decode.optional(resource()))
  |> decode.field("likes_flavor", decode.optional(resource()))
  |> decode.field("hates_flavor", decode.optional(resource()))
  |> decode.field(
    "pokeathlon_stat_changes",
    decode.list(of: nature_stat_change()),
  )
  |> decode.field(
    "move_battle_style_preferences",
    decode.list(of: move_battle_style_preference()),
  )
  |> decode.field("names", decode.list(of: name()))
}

fn nature_stat_change() {
  decode.into({
    use max_change <- decode.parameter
    use pokeathlon_stat <- decode.parameter
    NatureStatChange(max_change, pokeathlon_stat)
  })
  |> decode.field("max_change", decode.int)
  |> decode.field("pokeathlon_stat", resource())
}

fn move_battle_style_preference() {
  decode.into({
    use low_hp_preference <- decode.parameter
    use high_hp_preference <- decode.parameter
    use move_battle_style <- decode.parameter
    MoveBattleStylePreference(
      low_hp_preference,
      high_hp_preference,
      move_battle_style,
    )
  })
  |> decode.field("low_hp_preference", decode.int)
  |> decode.field("high_hp_preference", decode.int)
  |> decode.field("move_battle_style", resource())
}
