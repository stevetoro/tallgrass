import gleam/list
import gleeunit/should
import tallgrass/game/pokedex.{type Pokedex}

pub fn fetch_by_id_test() {
  pokedex.fetch_by_id(2) |> should.be_ok |> should_be_kanto
}

pub fn fetch_by_name_test() {
  pokedex.fetch_by_name("kanto") |> should.be_ok |> should_be_kanto
}

fn should_be_kanto(pokedex: Pokedex) {
  pokedex.id |> should.equal(2)
  pokedex.name |> should.equal("kanto")
  pokedex.is_main_series |> should.be_true

  let description = pokedex.descriptions |> list.first |> should.be_ok
  description.text
  |> should.equal("Pokédex régional de Kanto dans Rouge/Bleu/Jaune")
  description.language.name |> should.equal("fr")
  description.language.url
  |> should.equal("https://pokeapi.co/api/v2/language/5/")

  let name = pokedex.names |> list.first |> should.be_ok
  name.name |> should.equal("Kanto")
  name.language.name |> should.equal("fr")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/5/")

  let pokemon_entry = pokedex.pokemon_entries |> list.first |> should.be_ok
  pokemon_entry.entry |> should.equal(1)
  pokemon_entry.species.name |> should.equal("bulbasaur")
  pokemon_entry.species.url
  |> should.equal("https://pokeapi.co/api/v2/pokemon-species/1/")

  pokedex.region.name |> should.equal("kanto")
  pokedex.region.url |> should.equal("https://pokeapi.co/api/v2/region/1/")

  let version_group = pokedex.version_groups |> list.first |> should.be_ok
  version_group.name |> should.equal("red-blue")
  version_group.url
  |> should.equal("https://pokeapi.co/api/v2/version-group/1/")
}
