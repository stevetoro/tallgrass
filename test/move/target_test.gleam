import gleam/list
import gleam/option.{None}
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/move/target.{type MoveTarget}
import tallgrass/resource.{NamedResource}

pub fn fetch_test() {
  let response = target.fetch(options: None) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  target.fetch_resource(resource) |> should.be_ok |> should_be_specific_move
}

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

  let assert NamedResource(url, name) = description.language
  name |> should.equal("de")
  url |> should.equal("https://pokeapi.co/api/v2/language/6/")

  let assert NamedResource(url, name) =
    target.moves |> list.first |> should.be_ok
  name |> should.equal("counter")
  url |> should.equal("https://pokeapi.co/api/v2/move/68/")

  let name = target.names |> should_have_english_name
  name.name |> should.equal("Specific move")
}
