import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/location.{type Location}
import tallgrass/resource.{NamedResource}

pub fn fetch_by_id_test() {
  location.fetch_by_id(1) |> should.be_ok |> should_be_canalave_city
}

pub fn fetch_by_name_test() {
  location.fetch_by_name("canalave-city")
  |> should.be_ok
  |> should_be_canalave_city
}

fn should_be_canalave_city(location: Location) {
  location.id |> should.equal(1)
  location.name |> should.equal("canalave-city")

  let assert NamedResource(url, name) = location.region
  name |> should.equal("sinnoh")
  url |> should.equal("https://pokeapi.co/api/v2/region/4/")

  let name = location.names |> should_have_english_name
  name.name |> should.equal("Canalave City")

  let game_index = location.game_indices |> list.first |> should.be_ok
  game_index.index |> should.equal(7)

  let assert NamedResource(url, name) = game_index.generation
  name |> should.equal("generation-iv")
  url |> should.equal("https://pokeapi.co/api/v2/generation/4/")

  let assert NamedResource(url, name) =
    location.areas |> list.first |> should.be_ok
  name |> should.equal("canalave-city-area")
  url |> should.equal("https://pokeapi.co/api/v2/location-area/1/")
}
