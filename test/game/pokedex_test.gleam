import gleam/list
import gleam/option.{Some}
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/game/pokedex.{type Pokedex}
import tallgrass/resource.{NamedResource, PaginationOptions}

pub fn fetch_test() {
  let options = PaginationOptions(limit: 1, offset: 1)
  let response = pokedex.fetch(options: Some(options)) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  pokedex.fetch_resource(resource) |> should.be_ok |> should_be_kanto
}

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

  let assert NamedResource(url, name) = description.language
  name |> should.equal("fr")
  url |> should.equal("https://pokeapi.co/api/v2/language/5/")

  let name = pokedex.names |> should_have_english_name
  name.name |> should.equal("Kanto")

  let pokemon_entry = pokedex.pokemon_entries |> list.first |> should.be_ok
  pokemon_entry.entry |> should.equal(1)

  let assert NamedResource(url, name) = pokemon_entry.species
  name |> should.equal("bulbasaur")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon-species/1/")

  let assert NamedResource(url, name) = pokedex.region
  name |> should.equal("kanto")
  url |> should.equal("https://pokeapi.co/api/v2/region/1/")

  let assert NamedResource(url, name) =
    pokedex.version_groups |> list.first |> should.be_ok
  name |> should.equal("red-blue")
  url |> should.equal("https://pokeapi.co/api/v2/version-group/1/")
}
