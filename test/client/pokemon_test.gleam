import api/pokemon.{type Pokemon}
import client/pokemon as client
import gleam/list
import gleeunit/should

pub fn get_pokemon_by_id_test() {
  let assert Ok(pokemon) = client.fetch_by_id(1)
  pokemon
  |> should_be_bulbasaur
}

pub fn get_pokemon_by_name_test() {
  let assert Ok(pokemon) = client.fetch_by_name("bulbasaur")
  pokemon
  |> should_be_bulbasaur
}

fn should_be_bulbasaur(pokemon: Pokemon) {
  pokemon.id
  |> should.equal(1)

  pokemon.name
  |> should.equal("bulbasaur")

  let assert Ok(ability) = pokemon.abilities |> list.first

  ability.name
  |> should.equal("overgrow")

  ability.affordance.url
  |> should.equal("https://pokeapi.co/api/v2/ability/65/")

  ability.is_hidden
  |> should.be_false

  ability.slot
  |> should.equal(1)

  pokemon.base_experience
  |> should.equal(64)

  pokemon.cries.latest
  |> should.equal(
    "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/1.ogg",
  )

  pokemon.cries.legacy
  |> should.equal(
    "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/legacy/1.ogg",
  )

  let assert Ok(form) = pokemon.forms |> list.first

  form.name
  |> should.equal("bulbasaur")

  form.url
  |> should.equal("https://pokeapi.co/api/v2/pokemon-form/1/")

  let assert Ok(index) = pokemon.game_indices |> list.first

  index.index
  |> should.equal(153)

  index.version.name
  |> should.equal("red")

  index.version.url
  |> should.equal("https://pokeapi.co/api/v2/version/1/")

  pokemon.height
  |> should.equal(7)

  pokemon.is_default
  |> should.be_true

  pokemon.location_area_encounters
  |> should.equal("https://pokeapi.co/api/v2/pokemon/1/encounters")

  let assert Ok(move) = pokemon.moves |> list.first

  move.name
  |> should.equal("razor-wind")

  move.affordance.url
  |> should.equal("https://pokeapi.co/api/v2/move/13/")

  let assert Ok(details) = move.version_details |> list.first

  details.learn_level
  |> should.equal(0)

  details.learn_method.name
  |> should.equal("egg")

  details.learn_method.url
  |> should.equal("https://pokeapi.co/api/v2/move-learn-method/2/")

  details.version_group.name
  |> should.equal("gold-silver")

  details.version_group.url
  |> should.equal("https://pokeapi.co/api/v2/version-group/3/")

  pokemon.order
  |> should.equal(1)

  pokemon.species.name
  |> should.equal("bulbasaur")

  pokemon.species.url
  |> should.equal("https://pokeapi.co/api/v2/pokemon-species/1/")

  let assert Ok(stat) = pokemon.stats |> list.first

  stat.base_stat
  |> should.equal(45)

  stat.effort
  |> should.equal(0)

  stat.name
  |> should.equal("hp")

  stat.affordance.url
  |> should.equal("https://pokeapi.co/api/v2/stat/1/")

  let assert Ok(type_) = pokemon.types |> list.first

  type_.slot
  |> should.equal(1)

  type_.name
  |> should.equal("grass")

  type_.affordance.url
  |> should.equal("https://pokeapi.co/api/v2/type/12/")

  pokemon.weight
  |> should.equal(69)
}
