import gleam/list
import gleeunit/should
import tallgrass/encounter/condition_value.{type EncounterConditionValue}

pub fn fetch_by_id_test() {
  condition_value.fetch_by_id(1) |> should.be_ok |> should_be_swarm_yes
}

pub fn fetch_by_name_test() {
  condition_value.fetch_by_name("swarm-yes")
  |> should.be_ok
  |> should_be_swarm_yes
}

fn should_be_swarm_yes(encounter_condition_value: EncounterConditionValue) {
  encounter_condition_value.id |> should.equal(1)
  encounter_condition_value.name |> should.equal("swarm-yes")

  encounter_condition_value.condition.name |> should.equal("swarm")
  encounter_condition_value.condition.url
  |> should.equal("https://pokeapi.co/api/v2/encounter-condition/1/")

  let name = encounter_condition_value.names |> list.first |> should.be_ok
  name.name |> should.equal("Während eines Schwarms")
  name.language.name |> should.equal("de")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/6/")
}
