import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/encounter/condition.{type EncounterCondition}
import tallgrass/client/resource.{NamedResource}

pub fn fetch_test() {
  let resource =
    condition.new()
    |> condition.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  condition.new()
  |> condition.fetch_resource(resource)
  |> should.be_ok
  |> should_be_swarm
}

pub fn fetch_by_id_test() {
  condition.new()
  |> condition.fetch_by_id(1)
  |> should.be_ok
  |> should_be_swarm
}

pub fn fetch_by_name_test() {
  condition.new()
  |> condition.fetch_by_name("swarm")
  |> should.be_ok
  |> should_be_swarm
}

fn should_be_swarm(encounter_condition: EncounterCondition) {
  encounter_condition.id |> should.equal(1)
  encounter_condition.name |> should.equal("swarm")

  let assert NamedResource(url, name) =
    encounter_condition.values |> list.first |> should.be_ok
  name |> should.equal("swarm-yes")
  url |> should.equal("https://pokeapi.co/api/v2/encounter-condition-value/1/")

  let name = encounter_condition.names |> should_have_english_name
  name.name |> should.equal("Swarm")
}
