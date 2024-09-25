import decode
import tallgrass/client.{type Client}
import tallgrass/common/pokemon_type.{type PokemonType, pokemon_type}
import tallgrass/common/version.{type VersionGameIndex, version_game_index}
import tallgrass/client/resource.{type Resource, resource}

pub type Pokemon {
  Pokemon(
    id: Int,
    name: String,
    abilities: List(PokemonAbility),
    base_experience: Int,
    cries: PokemonCries,
    forms: List(Resource),
    game_indices: List(VersionGameIndex),
    height: Int,
    is_default: Bool,
    location_area_encounters: String,
    moves: List(PokemonMove),
    order: Int,
    species: Resource,
    stats: List(PokemonStat),
    types: List(PokemonType),
    weight: Int,
  )
}

pub type PokemonAbility {
  PokemonAbility(ability: Resource, is_hidden: Bool, slot: Int)
}

pub type PokemonCries {
  PokemonCries(latest: String, legacy: String)
}

pub type PokemonMove {
  PokemonMove(move: Resource, version_details: List(PokemonMoveVersion))
}

pub type PokemonMoveVersion {
  PokemonMoveVersion(
    learn_level: Int,
    learn_method: Resource,
    version_group: Resource,
  )
}

pub type PokemonStat {
  PokemonStat(stat: Resource, base_stat: Int, effort: Int)
}

const path = "pokemon"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of pokemon resources.
///
/// # Example
///
/// ```gleam
/// let result = pokemon.new() |> pokemon.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches a pokemon given a pokemon resource.
///
/// # Example
///
/// ```gleam
/// let client = pokemon.new()
/// use res <- result.try(client |> pokemon.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> pokemon.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, pokemon())
}

/// Fetches a pokemon given the pokemon ID.
///
/// # Example
///
/// ```gleam
/// let result = pokemon.new() |> pokemon.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, pokemon())
}

/// Fetches a pokemon given the pokemon name.
///
/// # Example
///
/// ```gleam
/// let result = pokemon.new() |> pokemon.fetch_by_name("ditto")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, pokemon())
}

fn pokemon() {
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
  |> decode.field("abilities", decode.list(of: pokemon_ability()))
  |> decode.field("base_experience", decode.int)
  |> decode.field("cries", pokemon_cries())
  |> decode.field("forms", decode.list(of: resource()))
  |> decode.field("game_indices", decode.list(of: version_game_index()))
  |> decode.field("height", decode.int)
  |> decode.field("is_default", decode.bool)
  |> decode.field("location_area_encounters", decode.string)
  |> decode.field("moves", decode.list(of: pokemon_move()))
  |> decode.field("order", decode.int)
  |> decode.field("species", resource())
  |> decode.field("stats", decode.list(of: pokemon_stat()))
  |> decode.field("types", decode.list(of: pokemon_type()))
  |> decode.field("weight", decode.int)
}

fn pokemon_ability() {
  decode.into({
    use ability <- decode.parameter
    use is_hidden <- decode.parameter
    use slot <- decode.parameter
    PokemonAbility(ability, is_hidden, slot)
  })
  |> decode.field("ability", resource())
  |> decode.field("is_hidden", decode.bool)
  |> decode.field("slot", decode.int)
}

fn pokemon_cries() {
  decode.into({
    use latest <- decode.parameter
    use legacy <- decode.parameter
    PokemonCries(latest, legacy)
  })
  |> decode.field("latest", decode.string)
  |> decode.field("legacy", decode.string)
}

fn pokemon_move() {
  decode.into({
    use move <- decode.parameter
    use version_details <- decode.parameter
    PokemonMove(move, version_details)
  })
  |> decode.field("move", resource())
  |> decode.field(
    "version_group_details",
    decode.list(of: pokemon_move_version()),
  )
}

fn pokemon_move_version() {
  decode.into({
    use level_learned <- decode.parameter
    use learn_method <- decode.parameter
    use version_group <- decode.parameter
    PokemonMoveVersion(level_learned, learn_method, version_group)
  })
  |> decode.field("level_learned_at", decode.int)
  |> decode.field("move_learn_method", resource())
  |> decode.field("version_group", resource())
}

fn pokemon_stat() {
  decode.into({
    use stat <- decode.parameter
    use base_stat <- decode.parameter
    use effort <- decode.parameter
    PokemonStat(stat, base_stat, effort)
  })
  |> decode.field("stat", resource())
  |> decode.field("base_stat", decode.int)
  |> decode.field("effort", decode.int)
}
