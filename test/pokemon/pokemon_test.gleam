import gleam/list
import gleeunit/should
import tallgrass/cache.{NoCache}
import tallgrass/pokemon.{type Pokemon}
import tallgrass/resource.{DefaultPagination, NamedResource}

pub fn fetch_test() {
  let response = pokemon.fetch(DefaultPagination, NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  pokemon.fetch_resource(resource, NoCache)
  |> should.be_ok
  |> should_be_bulbasaur
}

pub fn fetch_by_id_test() {
  pokemon.fetch_by_id(1, NoCache) |> should.be_ok |> should_be_bulbasaur
}

pub fn fetch_by_name_test() {
  pokemon.fetch_by_name("bulbasaur", NoCache)
  |> should.be_ok
  |> should_be_bulbasaur
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

  let assert NamedResource(url, name) = pokemon.species
  name |> should.equal("bulbasaur")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon-species/1/")

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

  let assert NamedResource(url, name) = ability.ability
  name |> should.equal("overgrow")
  url |> should.equal("https://pokeapi.co/api/v2/ability/65/")

  let assert NamedResource(url, name) =
    pokemon.forms |> list.first |> should.be_ok
  name |> should.equal("bulbasaur")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon-form/1/")

  let index = pokemon.game_indices |> list.first |> should.be_ok
  index.index |> should.equal(153)

  let assert NamedResource(url, name) = index.version
  name |> should.equal("red")
  url |> should.equal("https://pokeapi.co/api/v2/version/1/")

  let move = pokemon.moves |> list.first |> should.be_ok
  let assert NamedResource(url, name) = move.move
  name |> should.equal("razor-wind")
  url |> should.equal("https://pokeapi.co/api/v2/move/13/")

  let details = move.version_details |> list.first |> should.be_ok
  details.learn_level |> should.equal(0)

  let assert NamedResource(url, name) = details.learn_method
  name |> should.equal("egg")
  url |> should.equal("https://pokeapi.co/api/v2/move-learn-method/2/")

  let assert NamedResource(url, name) = details.version_group
  name |> should.equal("gold-silver")
  url |> should.equal("https://pokeapi.co/api/v2/version-group/3/")

  let stat = pokemon.stats |> list.first |> should.be_ok
  stat.base_stat |> should.equal(45)
  stat.effort |> should.equal(0)

  let assert NamedResource(url, name) = stat.stat
  name |> should.equal("hp")
  url |> should.equal("https://pokeapi.co/api/v2/stat/1/")

  let pokemon_type = pokemon.types |> list.first |> should.be_ok
  pokemon_type.slot |> should.equal(1)

  let assert NamedResource(url, name) = pokemon_type.pokemon_type
  name |> should.equal("grass")
  url |> should.equal("https://pokeapi.co/api/v2/type/12/")
}
