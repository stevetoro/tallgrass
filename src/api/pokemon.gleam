import api/decode.{decode16}
import gleam/dynamic.{
  type Decoder, bool, decode2, decode3, field, int, list, string,
}

pub type Pokemon {
  Pokemon(
    id: Int,
    abilities: List(PokemonAbility),
    base_experience: Int,
    cries: Cry,
    forms: List(Form),
    game_indices: List(GameIndex),
    height: Int,
    is_default: Bool,
    location_area_encounters: String,
    moves: List(PokemonMove),
    name: String,
    order: Int,
    species: Species,
    stats: List(PokemonStat),
    types: List(PokemonType),
    weight: Int,
  )
}

pub fn pokemon() -> Decoder(Pokemon) {
  decode16(
    Pokemon,
    field("id", of: int),
    field("abilities", list(of: abilities())),
    field("base_experience", of: int),
    field("cries", cries()),
    field("forms", list(of: forms())),
    field("game_indices", list(of: game_indices())),
    field("height", of: int),
    field("is_default", of: bool),
    field("location_area_encounters", of: string),
    field("moves", list(of: moves())),
    field("name", of: string),
    field("order", of: int),
    field("species", of: species()),
    field("stats", list(of: stats())),
    field("types", list(of: types())),
    field("weight", of: int),
  )
}

pub type PokemonAbility {
  PokemonAbility(ability: Ability, is_hidden: Bool, slot: Int)
}

pub type Ability {
  Ability(name: String, url: String)
}

fn abilities() -> Decoder(PokemonAbility) {
  decode3(
    PokemonAbility,
    field("ability", ability()),
    field("is_hidden", bool),
    field("slot", int),
  )
}

fn ability() -> Decoder(Ability) {
  decode2(Ability, field("name", string), field("url", string))
}

pub type Cry {
  Cry(latest: String, legacy: String)
}

fn cries() -> Decoder(Cry) {
  decode2(Cry, field("latest", of: string), field("legacy", of: string))
}

pub type Form {
  Form(name: String, url: String)
}

fn forms() -> Decoder(Form) {
  decode2(Form, field("name", of: string), field("url", of: string))
}

pub type GameIndex {
  GameIndex(game_index: Int, version: Version)
}

fn game_indices() -> Decoder(GameIndex) {
  decode2(GameIndex, field("game_index", of: int), field("version", version()))
}

pub type Version {
  Version(name: String, url: String)
}

fn version() -> Decoder(Version) {
  decode2(Version, field("name", string), field("url", string))
}

pub type PokemonMove {
  PokemonMove(move: Move, version_group_details: List(VersionGroupDetails))
}

fn moves() -> Decoder(PokemonMove) {
  decode2(
    PokemonMove,
    field("move", move()),
    field("version_group_details", list(of: version_group_details())),
  )
}

pub type Move {
  Move(name: String, url: String)
}

fn move() -> Decoder(Move) {
  decode2(Move, field("name", string), field("url", string))
}

pub type VersionGroupDetails {
  VersionGroupDetails(
    level_learned_at: Int,
    move_learn_method: MoveLearnMethod,
    version_group: VersionGroup,
  )
}

fn version_group_details() -> Decoder(VersionGroupDetails) {
  decode3(
    VersionGroupDetails,
    field("level_learned_at", int),
    field("move_learn_method", move_learn_method()),
    field("version_group", version_group()),
  )
}

pub type MoveLearnMethod {
  MoveLearnMethod(name: String, url: String)
}

fn move_learn_method() -> Decoder(MoveLearnMethod) {
  decode2(MoveLearnMethod, field("name", string), field("url", string))
}

pub type VersionGroup {
  VersionGroup(name: String, url: String)
}

fn version_group() -> Decoder(VersionGroup) {
  decode2(VersionGroup, field("name", string), field("url", string))
}

pub type Species {
  Species(name: String, url: String)
}

fn species() -> Decoder(Species) {
  decode2(Species, field("name", string), field("url", string))
}

pub type PokemonStat {
  PokemonStat(base_stat: Int, effort: Int, stat: Stat)
}

fn stats() -> Decoder(PokemonStat) {
  decode3(
    PokemonStat,
    field("base_stat", int),
    field("effort", int),
    field("stat", stat()),
  )
}

pub type Stat {
  Stat(name: String, url: String)
}

fn stat() -> Decoder(Stat) {
  decode2(Stat, field("name", string), field("url", string))
}

pub type PokemonType {
  PokemonType(slot: Int, type_a: Type)
}

fn types() -> Decoder(PokemonType) {
  decode2(PokemonType, field("slot", int), field("type", type_()))
}

pub type Type {
  Type(name: String, url: String)
}

fn type_() -> Decoder(Type) {
  decode2(Type, field("name", string), field("url", string))
}
