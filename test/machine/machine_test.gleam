import gleeunit/should
import tallgrass/machine.{type Machine}
import tallgrass/resource.{NamedResource}

pub fn fetch_by_id_test() {
  machine.fetch_by_id(1) |> should.be_ok |> should_be_tm_00
}

fn should_be_tm_00(machine: Machine) {
  machine.id |> should.equal(1)

  let assert NamedResource(url, name) = machine.item
  name |> should.equal("tm00")
  url |> should.equal("https://pokeapi.co/api/v2/item/1288/")

  let assert NamedResource(url, name) = machine.move
  name |> should.equal("mega-punch")
  url |> should.equal("https://pokeapi.co/api/v2/move/5/")

  let assert NamedResource(url, name) = machine.version_group
  name |> should.equal("sword-shield")
  url |> should.equal("https://pokeapi.co/api/v2/version-group/20/")
}
