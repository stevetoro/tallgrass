import gleam/list
import gleeunit/should
import tallgrass/encounter/condition.{type EncounterCondition}
import tallgrass/resource.{NamedResource}

pub fn fetch_by_id_test() {
  condition.fetch_by_id(1) |> should.be_ok |> should_be_swarm
}

pub fn fetch_by_name_test() {
  condition.fetch_by_name("swarm") |> should.be_ok |> should_be_swarm
}

fn should_be_swarm(encounter_condition: EncounterCondition) {
  encounter_condition.id |> should.equal(1)
  encounter_condition.name |> should.equal("swarm")

  let assert NamedResource(url, name) =
    encounter_condition.values |> list.first |> should.be_ok
  name |> should.equal("swarm-yes")
  url |> should.equal("https://pokeapi.co/api/v2/encounter-condition-value/1/")

  let name = encounter_condition.names |> list.first |> should.be_ok
  name.name |> should.equal("Essaim")

  let assert NamedResource(url, name) = name.language
  name |> should.equal("fr")
  url |> should.equal("https://pokeapi.co/api/v2/language/5/")
}
