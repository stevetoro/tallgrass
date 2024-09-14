import gleam/list
import gleeunit/should
import tallgrass/client/pal_park_area as client
import tallgrass/internal/location/pal_park_area/pal_park_area.{type PalParkArea}

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_forest
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("forest") |> should.be_ok |> should_be_forest
}

fn should_be_forest(area: PalParkArea) {
  area.id |> should.equal(1)
  area.name |> should.equal("forest")

  let name = area.names |> list.first |> should.be_ok
  name.name |> should.equal("Forêt")
  name.language.name |> should.equal("fr")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/5/")
}
