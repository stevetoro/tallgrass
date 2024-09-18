import gleam/list
import gleeunit/should
import tallgrass/move/ailment.{type MoveAilment}

pub fn fetch_by_id_test() {
  ailment.fetch_by_id(1) |> should.be_ok |> should_be_paralysis
}

pub fn fetch_by_name_test() {
  ailment.fetch_by_name("paralysis") |> should.be_ok |> should_be_paralysis
}

fn should_be_paralysis(ailment: MoveAilment) {
  ailment.id |> should.equal(1)
  ailment.name |> should.equal("paralysis")

  let move = ailment.moves |> list.first |> should.be_ok
  move.name |> should.equal("thunder-punch")
  move.url |> should.equal("https://pokeapi.co/api/v2/move/9/")

  let name = ailment.names |> list.first |> should.be_ok
  name.name |> should.equal("Paralysie")
  name.language.name |> should.equal("fr")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/5/")
}
