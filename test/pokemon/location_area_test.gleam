import gleam/list
import gleeunit/should
import pokemon/location_area/client
import pokemon/location_area/location_area.{type LocationArea}

pub fn fetch_by_id_test() {
  client.fetch_for_pokemon_with_id(1)
  |> should.be_ok
  |> list.first
  |> should.be_ok
  |> should_be_cerulean_city_area
}

pub fn fetch_by_name_test() {
  client.fetch_for_pokemon_with_name("bulbasaur")
  |> should.be_ok
  |> list.first
  |> should.be_ok
  |> should_be_cerulean_city_area
}

fn should_be_cerulean_city_area(location_area: LocationArea) {
  location_area.location_area.name |> should.equal("cerulean-city-area")
  location_area.location_area.url
  |> should.equal("https://pokeapi.co/api/v2/location-area/281/")

  let version_detail =
    location_area.version_details |> list.first |> should.be_ok
  version_detail.max_chance |> should.equal(100)
  version_detail.version.name |> should.equal("yellow")
  version_detail.version.url
  |> should.equal("https://pokeapi.co/api/v2/version/3/")

  let encounter_detail =
    version_detail.encounter_details |> list.first |> should.be_ok
  encounter_detail.chance |> should.equal(100)
  encounter_detail.max_level |> should.equal(10)
  encounter_detail.min_level |> should.equal(10)
  encounter_detail.method.name |> should.equal("gift")
  encounter_detail.method.url
  |> should.equal("https://pokeapi.co/api/v2/encounter-method/18/")
  encounter_detail.condition_values |> list.is_empty |> should.be_true
}
