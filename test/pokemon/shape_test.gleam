import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/pokemon/shape.{type PokemonShape}
import tallgrass/resource.{Default, NamedResource}

pub fn fetch_test() {
  let response = shape.fetch(options: Default) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  shape.fetch_resource(resource) |> should.be_ok |> should_be_ball
}

pub fn fetch_by_id_test() {
  shape.fetch_by_id(1) |> should.be_ok |> should_be_ball
}

pub fn fetch_by_name_test() {
  shape.fetch_by_name("ball") |> should.be_ok |> should_be_ball
}

fn should_be_ball(shape: PokemonShape) {
  shape.id |> should.equal(1)
  shape.name |> should.equal("ball")

  let name = shape.names |> should_have_english_name
  name.name |> should.equal("Ball")

  let awesome_name = shape.awesome_names |> list.first |> should.be_ok
  awesome_name.name |> should.equal("Pomacé")

  let assert NamedResource(url, name) = awesome_name.language
  name |> should.equal("fr")
  url |> should.equal("https://pokeapi.co/api/v2/language/5/")

  let assert NamedResource(url, name) =
    shape.pokemon_species |> list.first |> should.be_ok
  name |> should.equal("shellder")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon-species/90/")
}
