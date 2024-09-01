import decode
import gleam/option.{type Option}
import pokegleam/common/affordance.{type Affordance, Affordance, affordance}
import pokegleam/common/name.{type Name, Name, name}

pub type Nature {
  Nature(
    id: Int,
    name: String,
    decreased_stat: Option(Affordance),
    increased_stat: Option(Affordance),
    likes_flavor: Option(Affordance),
    hates_flavor: Option(Affordance),
    pokeathlon_stat_changes: List(PokeathlonStatChange),
    move_battle_style_preferences: List(MoveBattleStylePreference),
    names: List(Name),
  )
}

pub type PokeathlonStatChange {
  PokeathlonStatChange(max_change: Int, pokeathlon_stat: Affordance)
}

pub type MoveBattleStylePreference {
  MoveBattleStylePreference(
    low_hp_preference: Int,
    high_hp_preference: Int,
    move_battle_style: Affordance,
  )
}

pub fn nature() {
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
  |> decode.field("decreased_stat", decode.optional(affordance()))
  |> decode.field("increased_stat", decode.optional(affordance()))
  |> decode.field("likes_flavor", decode.optional(affordance()))
  |> decode.field("hates_flavor", decode.optional(affordance()))
  |> decode.field(
    "pokeathlon_stat_changes",
    decode.list(of: pokeathlon_stat_change()),
  )
  |> decode.field(
    "move_battle_style_preferences",
    decode.list(of: move_battle_style_preference()),
  )
  |> decode.field("names", decode.list(of: name()))
}

fn pokeathlon_stat_change() {
  decode.into({
    use max_change <- decode.parameter
    use pokeathlon_stat <- decode.parameter
    PokeathlonStatChange(max_change, pokeathlon_stat)
  })
  |> decode.field("max_change", decode.int)
  |> decode.field("pokeathlon_stat", affordance())
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
  |> decode.field("move_battle_style", affordance())
}
