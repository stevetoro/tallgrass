import decode
import tallgrass/common/generation.{
  type GenerationGameIndex, generation_game_index,
}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type NamedResource, named_resource}

pub type PokemonType {
  PokemonType(
    id: Int,
    name: String,
    damage_relations: PokemonTypeDamageRelations,
    past_damage_relations: List(PokemonTypeDamageRelationsPast),
    game_indices: List(GenerationGameIndex),
    generation: NamedResource,
    move_damage_class: NamedResource,
    names: List(Name),
    pokemon: List(TypePokemon),
    moves: List(NamedResource),
  )
}

pub type PokemonTypeDamageRelationsPast {
  PokemonTypeDamageRelationsPast(
    generation: NamedResource,
    damage_relations: PokemonTypeDamageRelations,
  )
}

pub type PokemonTypeDamageRelations {
  PokemonTypeDamageRelations(
    no_damage_to: List(NamedResource),
    half_damage_to: List(NamedResource),
    double_damage_to: List(NamedResource),
    no_damage_from: List(NamedResource),
    half_damage_from: List(NamedResource),
    double_damage_from: List(NamedResource),
  )
}

pub type TypePokemon {
  TypePokemon(slot: Int, pokemon: NamedResource)
}

const path = "type"

/// Fetches a pokemon type by the pokemon type ID.
///
/// # Example
///
/// ```gleam
/// let result = pokemon_type.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, pokemon_type())
}

/// Fetches a pokemon type by the pokemon type name.
///
/// # Example
///
/// ```gleam
/// let result = pokemon_type.fetch_by_name("fairy")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, pokemon_type())
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
  |> decode.field("generation", named_resource())
  |> decode.field("move_damage_class", named_resource())
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon", decode.list(of: type_pokemon()))
  |> decode.field("moves", decode.list(of: named_resource()))
}

fn pokemon_type_damage_relations_past() {
  decode.into({
    use generation <- decode.parameter
    use damage_relations <- decode.parameter
    PokemonTypeDamageRelationsPast(generation, damage_relations)
  })
  |> decode.field("generation", named_resource())
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
  |> decode.field("no_damage_to", decode.list(of: named_resource()))
  |> decode.field("half_damage_to", decode.list(of: named_resource()))
  |> decode.field("double_damage_to", decode.list(of: named_resource()))
  |> decode.field("no_damage_from", decode.list(of: named_resource()))
  |> decode.field("half_damage_from", decode.list(of: named_resource()))
  |> decode.field("double_damage_from", decode.list(of: named_resource()))
}

fn type_pokemon() {
  decode.into({
    use slot <- decode.parameter
    use pokemon <- decode.parameter
    TypePokemon(slot, pokemon)
  })
  |> decode.field("slot", decode.int)
  |> decode.field("pokemon", named_resource())
}