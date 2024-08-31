import api/affordance.{type Affordance, Affordance, affordance}
import decode

pub type PokemonType {
  PokemonType(
    id: Int,
    name: String,
    damage_relations: DamageRelations,
    past_damage_relations: List(PastDamageRelations),
    game_indices: List(GameIndex),
    generation: Affordance,
    move_damage_class: Affordance,
    names: List(Name),
    pokemon: List(Pokemon),
    moves: List(Affordance),
  )
}

pub type DamageRelations {
  DamageRelations(
    no_damage_to: List(Affordance),
    half_damage_to: List(Affordance),
    double_damage_to: List(Affordance),
    no_damage_from: List(Affordance),
    half_damage_from: List(Affordance),
    double_damage_from: List(Affordance),
  )
}

pub type PastDamageRelations {
  PastDamageRelations(generation: Affordance, damage_relations: DamageRelations)
}

pub type GameIndex {
  GameIndex(game_index: Int, generation: Affordance)
}

pub type Pokemon {
  Pokemon(slot: Int, pokemon: Affordance)
}

pub type Name {
  Name(name: String, language: Affordance)
}

pub fn pokemon_type() {
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
  |> decode.field("damage_relations", damage_relations())
  |> decode.field(
    "past_damage_relations",
    decode.list(of: past_damage_relations()),
  )
  |> decode.field("game_indices", decode.list(of: game_index()))
  |> decode.field("generation", affordance())
  |> decode.field("move_damage_class", affordance())
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon", decode.list(of: pokemon()))
  |> decode.field("moves", decode.list(of: affordance()))
}

fn past_damage_relations() {
  decode.into({
    use generation <- decode.parameter
    use damage_relations <- decode.parameter
    PastDamageRelations(generation, damage_relations)
  })
  |> decode.field("generation", affordance())
  |> decode.field("damage_relations", damage_relations())
}

fn damage_relations() {
  decode.into({
    use no_damage_to <- decode.parameter
    use half_damage_to <- decode.parameter
    use double_damage_to <- decode.parameter
    use no_damage_from <- decode.parameter
    use half_damage_from <- decode.parameter
    use double_damage_from <- decode.parameter
    DamageRelations(
      no_damage_to,
      half_damage_to,
      double_damage_to,
      no_damage_from,
      half_damage_from,
      double_damage_from,
    )
  })
  |> decode.field("no_damage_to", decode.list(of: affordance()))
  |> decode.field("half_damage_to", decode.list(of: affordance()))
  |> decode.field("double_damage_to", decode.list(of: affordance()))
  |> decode.field("no_damage_from", decode.list(of: affordance()))
  |> decode.field("half_damage_from", decode.list(of: affordance()))
  |> decode.field("double_damage_from", decode.list(of: affordance()))
}

fn game_index() {
  decode.into({
    use index <- decode.parameter
    use generation <- decode.parameter
    GameIndex(index, generation)
  })
  |> decode.field("game_index", decode.int)
  |> decode.field("generation", affordance())
}

fn name() {
  decode.into({
    use name <- decode.parameter
    use language <- decode.parameter
    Name(name, language)
  })
  |> decode.field("name", decode.string)
  |> decode.field("language", affordance())
}

fn pokemon() {
  decode.into({
    use slot <- decode.parameter
    use pokemon <- decode.parameter
    Pokemon(slot, pokemon)
  })
  |> decode.field("slot", decode.int)
  |> decode.field("pokemon", affordance())
}
