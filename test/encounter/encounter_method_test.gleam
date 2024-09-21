import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/encounter/method.{type EncounterMethod}

pub fn fetch_by_id_test() {
  method.fetch_by_id(1) |> should.be_ok |> should_be_walk
}

pub fn fetch_by_name_test() {
  method.fetch_by_name("walk") |> should.be_ok |> should_be_walk
}

fn should_be_walk(encounter_method: EncounterMethod) {
  encounter_method.id |> should.equal(1)
  encounter_method.name |> should.equal("walk")
  encounter_method.order |> should.equal(1)

  let name = encounter_method.names |> should_have_english_name
  name.name |> should.equal("Walking in tall grass or a cave")
  
}
