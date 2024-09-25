import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/common/resource.{NamedResource}
import tallgrass/game/generation.{type Generation}

pub fn fetch_test() {
  let resource =
    generation.new()
    |> generation.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  generation.new()
  |> generation.fetch_resource(resource)
  |> should.be_ok
  |> should_be_generation_i
}

pub fn fetch_by_id_test() {
  generation.new()
  |> generation.fetch_by_id(1)
  |> should.be_ok
  |> should_be_generation_i
}

pub fn fetch_by_name_test() {
  generation.new()
  |> generation.fetch_by_name("generation-i")
  |> should.be_ok
  |> should_be_generation_i
}

fn should_be_generation_i(generation: Generation) {
  generation.id |> should.equal(1)
  generation.name |> should.equal("generation-i")

  generation.abilities |> list.is_empty |> should.be_true

  let assert NamedResource(url, name) = generation.main_region
  name |> should.equal("kanto")
  url |> should.equal("https://pokeapi.co/api/v2/region/1/")

  let assert NamedResource(url, name) =
    generation.moves |> list.first |> should.be_ok
  name |> should.equal("pound")
  url |> should.equal("https://pokeapi.co/api/v2/move/1/")

  let name = generation.names |> should_have_english_name
  name.name |> should.equal("Generation I")

  let assert NamedResource(url, name) =
    generation.pokemon_species |> list.first |> should.be_ok
  name |> should.equal("bulbasaur")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon-species/1/")

  let assert NamedResource(url, name) =
    generation.types |> list.first |> should.be_ok
  name |> should.equal("normal")
  url |> should.equal("https://pokeapi.co/api/v2/type/1/")

  let assert NamedResource(url, name) =
    generation.version_groups |> list.first |> should.be_ok
  name |> should.equal("red-blue")
  url |> should.equal("https://pokeapi.co/api/v2/version-group/1/")
}
