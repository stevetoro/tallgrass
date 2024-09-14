import gleam/list
import gleeunit/should
import tallgrass/client/location as client
import tallgrass/internal/location/location/location.{type Location}

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_canalave_city
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("canalave-city")
  |> should.be_ok
  |> should_be_canalave_city
}

fn should_be_canalave_city(location: Location) {
  location.id |> should.equal(1)
  location.name |> should.equal("canalave-city")

  location.region.name |> should.equal("sinnoh")
  location.region.url |> should.equal("https://pokeapi.co/api/v2/region/4/")

  let name = location.names |> list.first |> should.be_ok
  name.name |> should.equal("Joliberges")
  name.language.name |> should.equal("fr")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/5/")

  let game_index = location.game_indices |> list.first |> should.be_ok
  game_index.index |> should.equal(7)
  game_index.generation.name |> should.equal("generation-iv")
  game_index.generation.url
  |> should.equal("https://pokeapi.co/api/v2/generation/4/")

  let area = location.areas |> list.first |> should.be_ok
  area.name |> should.equal("canalave-city-area")
  area.url |> should.equal("https://pokeapi.co/api/v2/location-area/1/")
}
