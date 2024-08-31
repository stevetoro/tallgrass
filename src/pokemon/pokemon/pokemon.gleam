import affordance/affordance.{type Affordance, Affordance, affordance}
import decode

pub type Pokemon {
  Pokemon(
    id: Int,
    name: String,
    abilities: List(Ability),
    base_experience: Int,
    cries: Cry,
    forms: List(Affordance),
    game_indices: List(GameIndex),
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
  Ability(name: String, affordance: Affordance, is_hidden: Bool, slot: Int)
}

pub type Cry {
  Cry(latest: String, legacy: String)
}

pub type GameIndex {
  GameIndex(index: Int, version: Affordance)
}

pub type Move {
  Move(
    name: String,
    affordance: Affordance,
    version_details: List(MoveVersionDetails),
  )
}

pub type MoveVersionDetails {
  MoveVersionDetails(
    learn_level: Int,
    learn_method: Affordance,
    version_group: Affordance,
  )
}

pub type Stat {
  Stat(name: String, affordance: Affordance, base_stat: Int, effort: Int)
}

pub type Type {
  Type(name: String, affordance: Affordance, slot: Int)
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
  |> decode.field("game_indices", decode.list(of: game_index()))
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
    use name <- decode.parameter
    use url <- decode.parameter
    use is_hidden <- decode.parameter
    use slot <- decode.parameter
    Ability(name, Affordance(name, url), is_hidden, slot)
  })
  |> decode.subfield(["ability", "name"], decode.string)
  |> decode.subfield(["ability", "url"], decode.string)
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

fn game_index() {
  decode.into({
    use index <- decode.parameter
    use name <- decode.parameter
    use url <- decode.parameter
    GameIndex(index, Affordance(name, url))
  })
  |> decode.field("game_index", decode.int)
  |> decode.subfield(["version", "name"], decode.string)
  |> decode.subfield(["version", "url"], decode.string)
}

fn move() {
  decode.into({
    use name <- decode.parameter
    use url <- decode.parameter
    use version_details <- decode.parameter
    Move(name, Affordance(name, url), version_details)
  })
  |> decode.subfield(["move", "name"], decode.string)
  |> decode.subfield(["move", "url"], decode.string)
  |> decode.field(
    "version_group_details",
    decode.list(of: move_version_details()),
  )
}

fn move_version_details() {
  decode.into({
    use level_learned <- decode.parameter
    use learn_method_name <- decode.parameter
    use learn_method_url <- decode.parameter
    use version_group_name <- decode.parameter
    use version_group_url <- decode.parameter
    MoveVersionDetails(
      level_learned,
      Affordance(learn_method_name, learn_method_url),
      Affordance(version_group_name, version_group_url),
    )
  })
  |> decode.field("level_learned_at", decode.int)
  |> decode.subfield(["move_learn_method", "name"], decode.string)
  |> decode.subfield(["move_learn_method", "url"], decode.string)
  |> decode.subfield(["version_group", "name"], decode.string)
  |> decode.subfield(["version_group", "url"], decode.string)
}

fn stat() {
  decode.into({
    use name <- decode.parameter
    use url <- decode.parameter
    use base_stat <- decode.parameter
    use effort <- decode.parameter
    Stat(name, Affordance(name, url), base_stat, effort)
  })
  |> decode.subfield(["stat", "name"], decode.string)
  |> decode.subfield(["stat", "url"], decode.string)
  |> decode.field("base_stat", decode.int)
  |> decode.field("effort", decode.int)
}

fn types() {
  decode.into({
    use name <- decode.parameter
    use url <- decode.parameter
    use slot <- decode.parameter
    Type(name, Affordance(name, url), slot)
  })
  |> decode.subfield(["type", "name"], decode.string)
  |> decode.subfield(["type", "url"], decode.string)
  |> decode.field("slot", decode.int)
}
