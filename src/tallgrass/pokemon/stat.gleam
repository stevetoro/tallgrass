import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type NamedResource, named_resource}

pub type Stat {
  Stat(
    id: Int,
    name: String,
    game_index: Int,
    is_battle_only: Bool,
    affecting_moves: MoveStatAffectSets,
    affecting_natures: NatureStatAffectSets,
    move_damage_class: NamedResource,
    names: List(Name),
  )
}

pub type NatureStatAffectSets {
  NatureStatAffectSets(
    increase: List(NamedResource),
    decrease: List(NamedResource),
  )
}

pub type MoveStatAffectSets {
  MoveStatAffectSets(
    increase: List(MoveStatAffect),
    decrease: List(MoveStatAffect),
  )
}

pub type MoveStatAffect {
  MoveStatAffect(change: Int, move: NamedResource)
}

const path = "stat"

/// Fetches a pokemon stat by the stat ID.
///
/// # Example
///
/// ```gleam
/// let result = stat.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, stat())
}

/// Fetches a pokemon stat by the stat name.
///
/// # Example
///
/// ```gleam
/// let result = stat.fetch_by_name("hp")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, stat())
}

fn stat() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use game_index <- decode.parameter
    use is_battle_only <- decode.parameter
    use affecting_moves <- decode.parameter
    use affecting_natures <- decode.parameter
    use move_damage_class <- decode.parameter
    use names <- decode.parameter
    Stat(
      id,
      name,
      game_index,
      is_battle_only,
      affecting_moves,
      affecting_natures,
      move_damage_class,
      names,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("game_index", decode.int)
  |> decode.field("is_battle_only", decode.bool)
  |> decode.field("affecting_moves", move_stat_affect_sets())
  |> decode.field("affecting_natures", nature_stat_affect_sets())
  |> decode.field("move_damage_class", named_resource())
  |> decode.field("names", decode.list(of: name()))
}

fn nature_stat_affect_sets() {
  decode.into({
    use increase <- decode.parameter
    use decrease <- decode.parameter
    NatureStatAffectSets(increase, decrease)
  })
  |> decode.field("increase", decode.list(of: named_resource()))
  |> decode.field("decrease", decode.list(of: named_resource()))
}

fn move_stat_affect_sets() {
  decode.into({
    use increase <- decode.parameter
    use decrease <- decode.parameter
    MoveStatAffectSets(increase, decrease)
  })
  |> decode.field("increase", decode.list(of: move_stat_affect()))
  |> decode.field("decrease", decode.list(of: move_stat_affect()))
}

fn move_stat_affect() {
  decode.into({
    use max_change <- decode.parameter
    use move <- decode.parameter
    MoveStatAffect(max_change, move)
  })
  |> decode.field("change", decode.int)
  |> decode.field("move", named_resource())
}
