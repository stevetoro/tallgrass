import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type Stat {
  Stat(
    id: Int,
    name: String,
    game_index: Int,
    is_battle_only: Bool,
    affecting_moves: MoveStatAffectSets,
    affecting_natures: NatureStatAffectSets,
    move_damage_class: Resource,
    names: List(Name),
  )
}

pub type NatureStatAffectSets {
  NatureStatAffectSets(increase: List(Resource), decrease: List(Resource))
}

pub type MoveStatAffectSets {
  MoveStatAffectSets(
    increase: List(MoveStatAffect),
    decrease: List(MoveStatAffect),
  )
}

pub type MoveStatAffect {
  MoveStatAffect(change: Int, move: Resource)
}

const path = "stat"

/// Fetches a list of pokemon stat resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = stat.fetch(options: Default)
/// let result = stat.fetch(options: Some(PaginationOptions(limit: 100, offset: 0)))
/// ```
pub fn fetch(options options: PaginationOptions) {
  resource.fetch_resources(path, options)
}

/// Fetches a pokemon stat given a pokemon stat resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(stat.fetch(options: Default))
/// let assert Ok(first) = res.results |> list.first
/// stat.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: stat())
}

/// Fetches a pokemon stat given the pokemon stat ID.
///
/// # Example
///
/// ```gleam
/// let result = stat.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, stat())
}

/// Fetches a pokemon stat given the pokemon stat name.
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
  |> decode.field("move_damage_class", resource())
  |> decode.field("names", decode.list(of: name()))
}

fn nature_stat_affect_sets() {
  decode.into({
    use increase <- decode.parameter
    use decrease <- decode.parameter
    NatureStatAffectSets(increase, decrease)
  })
  |> decode.field("increase", decode.list(of: resource()))
  |> decode.field("decrease", decode.list(of: resource()))
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
  |> decode.field("move", resource())
}
