import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/cache.{NoCache}
import tallgrass/location/area.{type LocationArea}
import tallgrass/resource.{Default, NamedResource}

pub fn fetch_test() {
  let response = area.fetch(options: Default, cache: NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  area.fetch_resource(resource, NoCache)
  |> should.be_ok
  |> should_be_canalave_city_area
}

pub fn fetch_by_id_test() {
  area.fetch_by_id(1, NoCache) |> should.be_ok |> should_be_canalave_city_area
}

pub fn fetch_by_name_test() {
  area.fetch_by_name("canalave-city-area", NoCache)
  |> should.be_ok
  |> should_be_canalave_city_area
}

fn should_be_canalave_city_area(area: LocationArea) {
  area.id |> should.equal(1)
  area.name |> should.equal("canalave-city-area")
  area.game_index |> should.equal(1)

  let assert NamedResource(url, name) = area.location
  name |> should.equal("canalave-city")
  url |> should.equal("https://pokeapi.co/api/v2/location/1/")

  let name = area.names |> should_have_english_name
  name.name |> should.equal("Canalave City")
}
