import gleam/list
import gleeunit/should
import tallgrass/move/category.{type MoveCategory}

pub fn fetch_by_id_test() {
  category.fetch_by_id(1) |> should.be_ok |> should_be_ailment
}

pub fn fetch_by_name_test() {
  category.fetch_by_name("ailment") |> should.be_ok |> should_be_ailment
}

fn should_be_ailment(category: MoveCategory) {
  category.id |> should.equal(1)
  category.name |> should.equal("ailment")

  let description = category.descriptions |> list.first |> should.be_ok
  description.text |> should.equal("No damage; inflicts status ailment")
  description.language.name |> should.equal("en")
  description.language.url
  |> should.equal("https://pokeapi.co/api/v2/language/9/")

  let move = category.moves |> list.first |> should.be_ok
  move.name |> should.equal("sing")
  move.url |> should.equal("https://pokeapi.co/api/v2/move/47/")
}
