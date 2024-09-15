import decode
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}
import tallgrass/internal/common/game_index.{
  type GameIndexVersion, GameIndexVersion, game_index_version,
}
import tallgrass/internal/common/pokemon_type.{type Type, Type, types}
import tallgrass/fetch

pub type Pokemon {
  Pokemon(
    id: Int,
    name: String,
    abilities: List(Ability),
    base_experience: Int,
    cries: Cry,
    forms: List(Affordance),
    game_indices: List(GameIndexVersion),
    height: Int,
    is_default: Bool,
    location_area_encounters: String,
    moves: List(Move),
    order: Int,
    species: Affordance,
    stats: List(Stat),
    types: List(Type),
    weight: Int,
  )
}

pub type Ability {
  Ability(affordance: Affordance, is_hidden: Bool, slot: Int)
}

pub type Cry {
  Cry(latest: String, legacy: String)
}

pub type Move {
  Move(affordance: Affordance, version_details: List(MoveVersionDetails))
}

pub type MoveVersionDetails {
  MoveVersionDetails(
    learn_level: Int,
    learn_method: Affordance,
    version_group: Affordance,
  )
}

pub type Stat {
  Stat(affordance: Affordance, base_stat: Int, effort: Int)
}

const path = "pokemon"

/// Fetches a pokemon by the pokemon ID.
///
/// # Example
///
/// ```gleam
/// let result = pokemon.fetch_by_id(132)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, pokemon())
}

/// Fetches a pokemon by the pokemon name.
///
/// # Example
///
/// ```gleam
/// let result = pokemon.fetch_by_name("ditto")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, pokemon())
}

pub fn pokemon() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use abilities <- decode.parameter
    use base_experience <- decode.parameter
    use cries <- decode.parameter
    use forms <- decode.parameter
    use game_indices <- decode.parameter
    use height <- decode.parameter
    use is_default <- decode.parameter
    use location_area_encounters <- decode.parameter
    use moves <- decode.parameter
    use order <- decode.parameter
    use species <- decode.parameter
    use stats <- decode.parameter
    use types <- decode.parameter
    use weight <- decode.parameter
    Pokemon(
      id,
      name,
      abilities,
      base_experience,
      cries,
      forms,
      game_indices,
      height,
      is_default,
      location_area_encounters,
      moves,
      order,
      species,
      stats,
      types,
      weight,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("abilities", decode.list(of: ability()))
  |> decode.field("base_experience", decode.int)
  |> decode.field("cries", cry())
  |> decode.field("forms", decode.list(of: affordance()))
  |> decode.field("game_indices", decode.list(of: game_index_version()))
  |> decode.field("height", decode.int)
  |> decode.field("is_default", decode.bool)
  |> decode.field("location_area_encounters", decode.string)
  |> decode.field("moves", decode.list(of: move()))
  |> decode.field("order", decode.int)
  |> decode.field("species", affordance())
  |> decode.field("stats", decode.list(of: stat()))
  |> decode.field("types", decode.list(of: types()))
  |> decode.field("weight", decode.int)
}

fn ability() {
  decode.into({
    use ability <- decode.parameter
    use is_hidden <- decode.parameter
    use slot <- decode.parameter
    Ability(ability, is_hidden, slot)
  })
  |> decode.field("ability", affordance())
  |> decode.field("is_hidden", decode.bool)
  |> decode.field("slot", decode.int)
}

fn cry() {
  decode.into({
    use latest <- decode.parameter
    use legacy <- decode.parameter
    Cry(latest, legacy)
  })
  |> decode.field("latest", decode.string)
  |> decode.field("legacy", decode.string)
}

fn move() {
  decode.into({
    use move <- decode.parameter
    use version_details <- decode.parameter
    Move(move, version_details)
  })
  |> decode.field("move", affordance())
  |> decode.field(
    "version_group_details",
    decode.list(of: move_version_details()),
  )
}

fn move_version_details() {
  decode.into({
    use level_learned <- decode.parameter
    use learn_method <- decode.parameter
    use version_group <- decode.parameter
    MoveVersionDetails(level_learned, learn_method, version_group)
  })
  |> decode.field("level_learned_at", decode.int)
  |> decode.field("move_learn_method", affordance())
  |> decode.field("version_group", affordance())
}

fn stat() {
  decode.into({
    use stat <- decode.parameter
    use base_stat <- decode.parameter
    use effort <- decode.parameter
    Stat(stat, base_stat, effort)
  })
  |> decode.field("stat", affordance())
  |> decode.field("base_stat", decode.int)
  |> decode.field("effort", decode.int)
}
