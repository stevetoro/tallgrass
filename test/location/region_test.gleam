import gleam/list
import gleeunit/should
import tallgrass/client/region as client
import tallgrass/internal/location/region/region.{type Region}

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_kanto
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("kanto") |> should.be_ok |> should_be_kanto
}

fn should_be_kanto(region: Region) {
  region.id |> should.equal(1)
  region.name |> should.equal("kanto")

  let location = region.locations |> list.first |> should.be_ok
  location.name |> should.equal("celadon-city")
  location.url |> should.equal("https://pokeapi.co/api/v2/location/67/")

  region.main_generation.name |> should.equal("generation-i")
  region.main_generation.url
  |> should.equal("https://pokeapi.co/api/v2/generation/1/")

  let name = region.names |> list.first |> should.be_ok
  name.name |> should.equal("カントー")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")

  let pokedex = region.pokedexes |> list.first |> should.be_ok
  pokedex.name |> should.equal("kanto")
  pokedex.url |> should.equal("https://pokeapi.co/api/v2/pokedex/2/")

  let version_group = region.version_groups |> list.first |> should.be_ok
  version_group.name |> should.equal("red-blue")
  version_group.url
  |> should.equal("https://pokeapi.co/api/v2/version-group/1/")
}
