import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/cache.{NoCache}
import tallgrass/encounter/method.{type EncounterMethod}
import tallgrass/resource.{DefaultPagination}

pub fn fetch_test() {
  let response = method.fetch(DefaultPagination, NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  method.fetch_resource(resource, NoCache) |> should.be_ok |> should_be_walk
}

pub fn fetch_by_id_test() {
  method.fetch_by_id(1, NoCache) |> should.be_ok |> should_be_walk
}

pub fn fetch_by_name_test() {
  method.fetch_by_name("walk", NoCache) |> should.be_ok |> should_be_walk
}

fn should_be_walk(encounter_method: EncounterMethod) {
  encounter_method.id |> should.equal(1)
  encounter_method.name |> should.equal("walk")
  encounter_method.order |> should.equal(1)

  let name = encounter_method.names |> should_have_english_name
  name.name |> should.equal("Walking in tall grass or a cave")
}
