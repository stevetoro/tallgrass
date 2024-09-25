import decode
import tallgrass/client.{type Client}
import tallgrass/common/name.{type Name, name}
import tallgrass/common/resource.{type Resource, resource}

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

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of pokemon stat resources.
///
/// # Example
///
/// ```gleam
/// let result = stat.new() |> stat.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches a pokemon stat given a pokemon stat resource.
///
/// # Example
///
/// ```gleam
/// let client = stat.new()
/// use res <- result.try(client |> stat.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> stat.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, stat())
}

/// Fetches a pokemon stat given the pokemon stat ID.
///
/// # Example
///
/// ```gleam
/// let result = stat.new() |> stat.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, stat())
}

/// Fetches a pokemon stat given the pokemon stat name.
///
/// # Example
///
/// ```gleam
/// let result = stat.new() |> stat.fetch_by_name("attack")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  client.fetch_by_name(client, path, name, stat())
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
