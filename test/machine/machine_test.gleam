import gleeunit/should
import tallgrass/machine.{type Machine}

pub fn fetch_by_id_test() {
  machine.fetch_by_id(1) |> should.be_ok |> should_be_tm_00
}

fn should_be_tm_00(machine: Machine) {
  machine.id |> should.equal(1)

  machine.item.name |> should.equal("tm00")
  machine.item.url |> should.equal("https://pokeapi.co/api/v2/item/1288/")

  machine.move.name |> should.equal("mega-punch")
  machine.move.url |> should.equal("https://pokeapi.co/api/v2/move/5/")

  machine.version_group.name |> should.equal("sword-shield")
  machine.version_group.url
  |> should.equal("https://pokeapi.co/api/v2/version-group/20/")
}
