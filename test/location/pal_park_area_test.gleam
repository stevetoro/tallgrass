import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/cache.{NoCache}
import tallgrass/location/pal_park_area.{type PalParkArea}
import tallgrass/resource.{DefaultPagination}

pub fn fetch_test() {
  let response = pal_park_area.fetch(DefaultPagination, NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  pal_park_area.fetch_resource(resource, NoCache)
  |> should.be_ok
  |> should_be_forest
}

pub fn fetch_by_id_test() {
  pal_park_area.fetch_by_id(1, NoCache) |> should.be_ok |> should_be_forest
}

pub fn fetch_by_name_test() {
  pal_park_area.fetch_by_name("forest", NoCache)
  |> should.be_ok
  |> should_be_forest
}

fn should_be_forest(area: PalParkArea) {
  area.id |> should.equal(1)
  area.name |> should.equal("forest")

  let name = area.names |> should_have_english_name
  name.name |> should.equal("Forest")
}
