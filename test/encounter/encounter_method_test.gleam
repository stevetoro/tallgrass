import gleam/list
import gleeunit/should
import tallgrass/client/encounter_method as client
import tallgrass/internal/encounter/encounter_method/encounter_method.{
  type EncounterMethod,
}

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_walk
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("walk") |> should.be_ok |> should_be_walk
}

fn should_be_walk(encounter_method: EncounterMethod) {
  encounter_method.id |> should.equal(1)
  encounter_method.name |> should.equal("walk")
  encounter_method.order |> should.equal(1)

  let name = encounter_method.names |> list.first |> should.be_ok
  name.name |> should.equal("Im hohen Gras oder in einer Höhle laufen")
  name.language.name |> should.equal("de")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/6/")
}
