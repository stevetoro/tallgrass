import gleam/list
import gleeunit/should
import tallgrass/location/area.{type LocationArea}

pub fn fetch_by_id_test() {
  area.fetch_by_id(1) |> should.be_ok |> should_be_canalave_city_area
}

pub fn fetch_by_name_test() {
  area.fetch_by_name("canalave-city-area")
  |> should.be_ok
  |> should_be_canalave_city_area
}

fn should_be_canalave_city_area(area: LocationArea) {
  area.id |> should.equal(1)
  area.name |> should.equal("canalave-city-area")
  area.game_index |> should.equal(1)

  area.location.name |> should.equal("canalave-city")
  area.location.url |> should.equal("https://pokeapi.co/api/v2/location/1/")

  let name = area.names |> list.first |> should.be_ok
  name.name |> should.equal("Canalave City")
  name.language.name |> should.equal("en")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/9/")
}
