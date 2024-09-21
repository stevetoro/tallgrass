import decode
import gleam/option.{type Option}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

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

/// Fetches a list of pokemon nature resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = nature.fetch(options: None)
/// let result = nature.fetch(options: Some(PaginationOptions(limit: 100, offset: 0)))
/// ```
pub fn fetch(options options: Option(PaginationOptions)) {
  resource.fetch_resources(path, options)
}

/// Fetches a pokemon nature given a pokemon nature resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(nature.fetch(options: None))
/// let assert Ok(first) = res.results |> list.first
/// nature.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: nature())
}

/// Fetches a pokemon nature given the pokemon nature ID.
///
/// # Example
///
/// ```gleam
/// let result = nature.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, nature())
}

/// Fetches a pokemon nature given the pokemon nature name.
///
/// # Example
///
/// ```gleam
/// let result = nature.fetch_by_name("hardy")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, nature())
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
