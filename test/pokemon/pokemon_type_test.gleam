import gleam/list
import gleeunit/should
import pokemon/pokemon_type/client
import pokemon/pokemon_type/pokemon_type.{type PokemonType}

pub fn fetch_by_id_test() {
  client.fetch_by_id(9) |> should.be_ok |> should_be_steel
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("steel") |> should.be_ok |> should_be_steel
}

fn should_be_steel(pokemon_type: PokemonType) {
  pokemon_type.id |> should.equal(9)
  pokemon_type.name |> should.equal("steel")

  pokemon_type.damage_relations.no_damage_to
  |> list.is_empty
  |> should.be_true

  let half_damage_to =
    pokemon_type.damage_relations.half_damage_to |> list.first |> should.be_ok
  half_damage_to.name |> should.equal("steel")
  half_damage_to.url |> should.equal("https://pokeapi.co/api/v2/type/9/")

  let double_damage_to =
    pokemon_type.damage_relations.double_damage_to |> list.first |> should.be_ok
  double_damage_to.name |> should.equal("rock")
  double_damage_to.url |> should.equal("https://pokeapi.co/api/v2/type/6/")

  let no_damage_from =
    pokemon_type.damage_relations.no_damage_from |> list.first |> should.be_ok
  no_damage_from.name |> should.equal("poison")
  no_damage_from.url |> should.equal("https://pokeapi.co/api/v2/type/4/")

  let half_damage_from =
    pokemon_type.damage_relations.half_damage_from |> list.first |> should.be_ok
  half_damage_from.name |> should.equal("normal")
  half_damage_from.url |> should.equal("https://pokeapi.co/api/v2/type/1/")

  let double_damage_from =
    pokemon_type.damage_relations.double_damage_from
    |> list.first
    |> should.be_ok
  double_damage_from.name |> should.equal("fighting")
  double_damage_from.url |> should.equal("https://pokeapi.co/api/v2/type/2/")

  let past_damage_relations =
    pokemon_type.past_damage_relations |> list.first |> should.be_ok
  past_damage_relations.generation.name |> should.equal("generation-v")
  past_damage_relations.generation.url
  |> should.equal("https://pokeapi.co/api/v2/generation/5/")

  past_damage_relations.damage_relations.no_damage_to
  |> list.is_empty
  |> should.be_true

  let past_half_damage_to =
    past_damage_relations.damage_relations.half_damage_to
    |> list.first
    |> should.be_ok
  past_half_damage_to.name |> should.equal("steel")
  past_half_damage_to.url |> should.equal("https://pokeapi.co/api/v2/type/9/")

  let past_double_damage_to =
    past_damage_relations.damage_relations.double_damage_to
    |> list.first
    |> should.be_ok
  past_double_damage_to.name |> should.equal("rock")
  past_double_damage_to.url |> should.equal("https://pokeapi.co/api/v2/type/6/")

  let past_no_damage_from =
    past_damage_relations.damage_relations.no_damage_from
    |> list.first
    |> should.be_ok
  past_no_damage_from.name |> should.equal("poison")
  past_no_damage_from.url |> should.equal("https://pokeapi.co/api/v2/type/4/")

  let past_half_damage_from =
    past_damage_relations.damage_relations.half_damage_from
    |> list.first
    |> should.be_ok
  past_half_damage_from.name |> should.equal("normal")
  past_half_damage_from.url |> should.equal("https://pokeapi.co/api/v2/type/1/")

  let past_double_damage_from =
    past_damage_relations.damage_relations.double_damage_from
    |> list.first
    |> should.be_ok
  past_double_damage_from.name |> should.equal("fighting")
  past_double_damage_from.url
  |> should.equal("https://pokeapi.co/api/v2/type/2/")

  let game_index = pokemon_type.game_indices |> list.first |> should.be_ok
  game_index.game_index |> should.equal(9)
  game_index.generation.name |> should.equal("generation-ii")
  game_index.generation.url
  |> should.equal("https://pokeapi.co/api/v2/generation/2/")

  pokemon_type.generation.name |> should.equal("generation-ii")
  pokemon_type.generation.url
  |> should.equal("https://pokeapi.co/api/v2/generation/2/")

  pokemon_type.move_damage_class.name |> should.equal("physical")
  pokemon_type.move_damage_class.url
  |> should.equal("https://pokeapi.co/api/v2/move-damage-class/2/")

  let name = pokemon_type.names |> list.first |> should.be_ok
  name.name |> should.equal("はがね")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")

  let pokemon = pokemon_type.pokemon |> list.first |> should.be_ok
  pokemon.slot |> should.equal(2)
  pokemon.pokemon.name |> should.equal("magnemite")
  pokemon.pokemon.url |> should.equal("https://pokeapi.co/api/v2/pokemon/81/")

  let move = pokemon_type.moves |> list.first |> should.be_ok
  move.name |> should.equal("steel-wing")
  move.url |> should.equal("https://pokeapi.co/api/v2/move/211/")
}
