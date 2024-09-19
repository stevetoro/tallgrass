import gleam/list
import gleeunit/should
import tallgrass/move/target.{type MoveTarget}

pub fn fetch_by_id_test() {
  target.fetch_by_id(1) |> should.be_ok |> should_be_specific_move
}

pub fn fetch_by_name_test() {
  target.fetch_by_name("specific-move")
  |> should.be_ok
  |> should_be_specific_move
}

fn should_be_specific_move(target: MoveTarget) {
  target.id |> should.equal(1)
  target.name |> should.equal("specific-move")

  let description = target.descriptions |> list.first |> should.be_ok
  description.text
  |> should.equal(
    "Eine spezifische Fähigkeit.  Wie diese Fähigkeit genutzt wird hängt von den genutzten Fähigkeiten ab.",
  )
  description.language.name |> should.equal("de")
  description.language.url
  |> should.equal("https://pokeapi.co/api/v2/language/6/")

  let move = target.moves |> list.first |> should.be_ok
  move.name |> should.equal("counter")
  move.url |> should.equal("https://pokeapi.co/api/v2/move/68/")

  let name = target.names |> list.first |> should.be_ok
  name.name |> should.equal("Spezifische Fähigkeit")
  name.language.name |> should.equal("de")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/6/")
}
