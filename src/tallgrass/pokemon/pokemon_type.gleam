import decode
import tallgrass/client.{type Client}
import tallgrass/common/resource.{type Resource, resource}
import tallgrass/common/generation.{
  type GenerationGameIndex, generation_game_index,
}
import tallgrass/common/name.{type Name, name}

pub type PokemonType {
  PokemonType(
    id: Int,
    name: String,
    damage_relations: PokemonTypeDamageRelations,
    past_damage_relations: List(PokemonTypeDamageRelationsPast),
    game_indices: List(GenerationGameIndex),
    generation: Resource,
    move_damage_class: Resource,
    names: List(Name),
    pokemon: List(TypePokemon),
    moves: List(Resource),
  )
}

pub type PokemonTypeDamageRelationsPast {
  PokemonTypeDamageRelationsPast(
    generation: Resource,
    damage_relations: PokemonTypeDamageRelations,
  )
}

pub type PokemonTypeDamageRelations {
  PokemonTypeDamageRelations(
    no_damage_to: List(Resource),
    half_damage_to: List(Resource),
    double_damage_to: List(Resource),
    no_damage_from: List(Resource),
    half_damage_from: List(Resource),
    double_damage_from: List(Resource),
  )
}

pub type TypePokemon {
  TypePokemon(slot: Int, pokemon: Resource)
}

const path = "type"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of pokemon type resources.
///
/// # Example
///
/// ```gleam
/// let result = pokemon_type.new() |> pokemon_type.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches a pokemon type given a pokemon type resource.
///
/// # Example
///
/// ```gleam
/// let client = pokemon_type.new()
/// use res <- result.try(client |> pokemon_type.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> pokemon_type.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, pokemon_type())
}

/// Fetches a pokemon type given the pokemon type ID.
///
/// # Example
///
/// ```gleam
/// let result = pokemon_type.new() |> pokemon_type.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, pokemon_type())
}

/// Fetches a pokemon type given the pokemon type name.
///
/// # Example
///
/// ```gleam
/// let result = pokemon_type.new() |> pokemon_type.fetch_by_name("fairy")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  client.fetch_by_name(client, path, name, pokemon_type())
}

fn pokemon_type() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use damage_relations <- decode.parameter
    use past_damage_relations <- decode.parameter
    use game_indices <- decode.parameter
    use generation <- decode.parameter
    use move_damage_class <- decode.parameter
    use names <- decode.parameter
    use pokemon <- decode.parameter
    use moves <- decode.parameter
    PokemonType(
      id,
      name,
      damage_relations,
      past_damage_relations,
      game_indices,
      generation,
      move_damage_class,
      names,
      pokemon,
      moves,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("damage_relations", pokemon_type_damage_relations())
  |> decode.field(
    "past_damage_relations",
    decode.list(of: pokemon_type_damage_relations_past()),
  )
  |> decode.field("game_indices", decode.list(of: generation_game_index()))
  |> decode.field("generation", resource())
  |> decode.field("move_damage_class", resource())
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon", decode.list(of: type_pokemon()))
  |> decode.field("moves", decode.list(of: resource()))
}

fn pokemon_type_damage_relations_past() {
  decode.into({
    use generation <- decode.parameter
    use damage_relations <- decode.parameter
    PokemonTypeDamageRelationsPast(generation, damage_relations)
  })
  |> decode.field("generation", resource())
  |> decode.field("damage_relations", pokemon_type_damage_relations())
}

fn pokemon_type_damage_relations() {
  decode.into({
    use no_damage_to <- decode.parameter
    use half_damage_to <- decode.parameter
    use double_damage_to <- decode.parameter
    use no_damage_from <- decode.parameter
    use half_damage_from <- decode.parameter
    use double_damage_from <- decode.parameter
    PokemonTypeDamageRelations(
      no_damage_to,
      half_damage_to,
      double_damage_to,
      no_damage_from,
      half_damage_from,
      double_damage_from,
    )
  })
  |> decode.field("no_damage_to", decode.list(of: resource()))
  |> decode.field("half_damage_to", decode.list(of: resource()))
  |> decode.field("double_damage_to", decode.list(of: resource()))
  |> decode.field("no_damage_from", decode.list(of: resource()))
  |> decode.field("half_damage_from", decode.list(of: resource()))
  |> decode.field("double_damage_from", decode.list(of: resource()))
}

fn type_pokemon() {
  decode.into({
    use slot <- decode.parameter
    use pokemon <- decode.parameter
    TypePokemon(slot, pokemon)
  })
  |> decode.field("slot", decode.int)
  |> decode.field("pokemon", resource())
}
