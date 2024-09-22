import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/cache.{NoCache}
import tallgrass/pokemon/pokemon_type.{type PokemonType}
import tallgrass/resource.{NamedResource, Offset}

pub fn fetch_test() {
  let response = pokemon_type.fetch(Offset(8), NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  pokemon_type.fetch_resource(resource, NoCache)
  |> should.be_ok
  |> should_be_steel
}

pub fn fetch_by_id_test() {
  pokemon_type.fetch_by_id(9, NoCache) |> should.be_ok |> should_be_steel
}

pub fn fetch_by_name_test() {
  pokemon_type.fetch_by_name("steel", NoCache)
  |> should.be_ok
  |> should_be_steel
}

fn should_be_steel(pokemon_type: PokemonType) {
  pokemon_type.id |> should.equal(9)
  pokemon_type.name |> should.equal("steel")

  pokemon_type.damage_relations.no_damage_to
  |> list.is_empty
  |> should.be_true

  let assert NamedResource(url, name) =
    pokemon_type.damage_relations.half_damage_to |> list.first |> should.be_ok
  name |> should.equal("steel")
  url |> should.equal("https://pokeapi.co/api/v2/type/9/")

  let assert NamedResource(url, name) =
    pokemon_type.damage_relations.double_damage_to |> list.first |> should.be_ok
  name |> should.equal("rock")
  url |> should.equal("https://pokeapi.co/api/v2/type/6/")

  let assert NamedResource(url, name) =
    pokemon_type.damage_relations.no_damage_from |> list.first |> should.be_ok
  name |> should.equal("poison")
  url |> should.equal("https://pokeapi.co/api/v2/type/4/")

  let assert NamedResource(url, name) =
    pokemon_type.damage_relations.half_damage_from |> list.first |> should.be_ok
  name |> should.equal("normal")
  url |> should.equal("https://pokeapi.co/api/v2/type/1/")

  let assert NamedResource(url, name) =
    pokemon_type.damage_relations.double_damage_from
    |> list.first
    |> should.be_ok
  name |> should.equal("fighting")
  url |> should.equal("https://pokeapi.co/api/v2/type/2/")

  let past_damage_relations =
    pokemon_type.past_damage_relations |> list.first |> should.be_ok

  let assert NamedResource(url, name) = past_damage_relations.generation
  name |> should.equal("generation-v")
  url |> should.equal("https://pokeapi.co/api/v2/generation/5/")

  past_damage_relations.damage_relations.no_damage_to
  |> list.is_empty
  |> should.be_true

  let assert NamedResource(url, name) =
    past_damage_relations.damage_relations.half_damage_to
    |> list.first
    |> should.be_ok
  name |> should.equal("steel")
  url |> should.equal("https://pokeapi.co/api/v2/type/9/")

  let assert NamedResource(url, name) =
    past_damage_relations.damage_relations.double_damage_to
    |> list.first
    |> should.be_ok
  name |> should.equal("rock")
  url |> should.equal("https://pokeapi.co/api/v2/type/6/")

  let assert NamedResource(url, name) =
    past_damage_relations.damage_relations.no_damage_from
    |> list.first
    |> should.be_ok
  name |> should.equal("poison")
  url |> should.equal("https://pokeapi.co/api/v2/type/4/")

  let assert NamedResource(url, name) =
    past_damage_relations.damage_relations.half_damage_from
    |> list.first
    |> should.be_ok
  name |> should.equal("normal")
  url |> should.equal("https://pokeapi.co/api/v2/type/1/")

  let assert NamedResource(url, name) =
    past_damage_relations.damage_relations.double_damage_from
    |> list.first
    |> should.be_ok
  name |> should.equal("fighting")
  url |> should.equal("https://pokeapi.co/api/v2/type/2/")

  let game_index = pokemon_type.game_indices |> list.first |> should.be_ok
  game_index.index |> should.equal(9)

  let assert NamedResource(url, name) = game_index.generation
  name |> should.equal("generation-ii")
  url |> should.equal("https://pokeapi.co/api/v2/generation/2/")

  let assert NamedResource(url, name) = pokemon_type.generation
  name |> should.equal("generation-ii")
  url |> should.equal("https://pokeapi.co/api/v2/generation/2/")

  let assert NamedResource(url, name) = pokemon_type.move_damage_class
  name |> should.equal("physical")
  url |> should.equal("https://pokeapi.co/api/v2/move-damage-class/2/")

  let name = pokemon_type.names |> should_have_english_name
  name.name |> should.equal("Steel")

  let pokemon = pokemon_type.pokemon |> list.first |> should.be_ok
  pokemon.slot |> should.equal(2)

  let assert NamedResource(url, name) = pokemon.pokemon
  name |> should.equal("magnemite")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon/81/")

  let assert NamedResource(url, name) =
    pokemon_type.moves |> list.first |> should.be_ok
  name |> should.equal("steel-wing")
  url |> should.equal("https://pokeapi.co/api/v2/move/211/")
}
