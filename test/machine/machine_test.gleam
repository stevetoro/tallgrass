import gleam/list
import gleeunit/should
import tallgrass/cache.{NoCache}
import tallgrass/machine.{type Machine}
import tallgrass/resource.{DefaultPagination, NamedResource}

pub fn fetch_test() {
  let response = machine.fetch(DefaultPagination, NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  machine.fetch_resource(resource, NoCache) |> should.be_ok |> should_be_tm_00
}

pub fn fetch_by_id_test() {
  machine.fetch_by_id(1, NoCache) |> should.be_ok |> should_be_tm_00
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
