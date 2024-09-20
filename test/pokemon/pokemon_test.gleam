import gleam/list
import gleam/option.{None}
import gleeunit/should
import tallgrass/pokemon.{type Pokemon}

pub fn fetch_test() {
  let response = pokemon.fetch(options: None) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  resource.name |> should.equal("bulbasaur")
  pokemon.fetch_resource(resource) |> should.be_ok |> should_be_bulbasaur
}

pub fn fetch_by_id_test() {
  pokemon.fetch_by_id(1) |> should.be_ok |> should_be_bulbasaur
}

pub fn fetch_by_name_test() {
  pokemon.fetch_by_name("bulbasaur") |> should.be_ok |> should_be_bulbasaur
}

fn should_be_bulbasaur(pokemon: Pokemon) {
  pokemon.id |> should.equal(1)
  pokemon.name |> should.equal("bulbasaur")
  pokemon.height |> should.equal(7)
  pokemon.weight |> should.equal(69)
  pokemon.base_experience |> should.equal(64)
  pokemon.is_default |> should.be_true
  pokemon.order |> should.equal(1)

  pokemon.location_area_encounters
  |> should.equal("https://pokeapi.co/api/v2/pokemon/1/encounters")

  pokemon.species.name |> should.equal("bulbasaur")
  pokemon.species.url
  |> should.equal("https://pokeapi.co/api/v2/pokemon-species/1/")

  pokemon.cries.latest
  |> should.equal(
    "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/1.ogg",
  )
  pokemon.cries.legacy
  |> should.equal(
    "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/legacy/1.ogg",
  )

  let ability = pokemon.abilities |> list.first |> should.be_ok
  ability.is_hidden |> should.be_false
  ability.slot |> should.equal(1)
  ability.ability.name |> should.equal("overgrow")
  ability.ability.url
  |> should.equal("https://pokeapi.co/api/v2/ability/65/")

  let form = pokemon.forms |> list.first |> should.be_ok
  form.name |> should.equal("bulbasaur")
  form.url |> should.equal("https://pokeapi.co/api/v2/pokemon-form/1/")

  let index = pokemon.game_indices |> list.first |> should.be_ok
  index.index |> should.equal(153)
  index.version.name |> should.equal("red")
  index.version.url |> should.equal("https://pokeapi.co/api/v2/version/1/")

  let move = pokemon.moves |> list.first |> should.be_ok
  move.move.name |> should.equal("razor-wind")
  move.move.url |> should.equal("https://pokeapi.co/api/v2/move/13/")

  let details = move.version_details |> list.first |> should.be_ok
  details.learn_level |> should.equal(0)
  details.learn_method.name |> should.equal("egg")
  details.learn_method.url
  |> should.equal("https://pokeapi.co/api/v2/move-learn-method/2/")
  details.version_group.name |> should.equal("gold-silver")
  details.version_group.url
  |> should.equal("https://pokeapi.co/api/v2/version-group/3/")

  let stat = pokemon.stats |> list.first |> should.be_ok
  stat.base_stat |> should.equal(45)
  stat.effort |> should.equal(0)
  stat.stat.name |> should.equal("hp")
  stat.stat.url
  |> should.equal("https://pokeapi.co/api/v2/stat/1/")

  let pokemon_type = pokemon.types |> list.first |> should.be_ok
  pokemon_type.slot |> should.equal(1)
  pokemon_type.pokemon_type.name |> should.equal("grass")
  pokemon_type.pokemon_type.url
  |> should.equal("https://pokeapi.co/api/v2/type/12/")
}
