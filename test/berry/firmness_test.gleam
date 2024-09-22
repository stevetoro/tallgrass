import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/berry/firmness.{type BerryFirmness}
import tallgrass/cache.{NoCache}
import tallgrass/resource.{DefaultPagination, NamedResource}

pub fn fetch_test() {
  let response = firmness.fetch(DefaultPagination, NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  firmness.fetch_resource(resource, NoCache)
  |> should.be_ok
  |> should_be_very_soft
}

pub fn fetch_by_id_test() {
  firmness.fetch_by_id(1, NoCache) |> should.be_ok |> should_be_very_soft
}

pub fn fetch_by_name_test() {
  firmness.fetch_by_name("very-soft", NoCache)
  |> should.be_ok
  |> should_be_very_soft
}

fn should_be_very_soft(firmness: BerryFirmness) {
  firmness.id |> should.equal(1)
  firmness.name |> should.equal("very-soft")

  let assert NamedResource(url, name) =
    firmness.berries |> list.first |> should.be_ok
  name |> should.equal("pecha")
  url |> should.equal("https://pokeapi.co/api/v2/berry/3/")

  let name = firmness.names |> should_have_english_name
  name.name |> should.equal("Very Soft")
}
