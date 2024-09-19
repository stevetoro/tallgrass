import gleam/list
import gleeunit/should
import tallgrass/move/damage_class.{type MoveDamageClass}

pub fn fetch_by_id_test() {
  damage_class.fetch_by_id(1) |> should.be_ok |> should_be_status
}

pub fn fetch_by_name_test() {
  damage_class.fetch_by_name("status") |> should.be_ok |> should_be_status
}

fn should_be_status(damage_class: MoveDamageClass) {
  damage_class.id |> should.equal(1)
  damage_class.name |> should.equal("status")

  let description = damage_class.descriptions |> list.first |> should.be_ok
  description.text |> should.equal("ダメージない")
  description.language.name |> should.equal("ja-Hrkt")
  description.language.url
  |> should.equal("https://pokeapi.co/api/v2/language/1/")

  let move = damage_class.moves |> list.first |> should.be_ok
  move.name |> should.equal("swords-dance")
  move.url |> should.equal("https://pokeapi.co/api/v2/move/14/")

  let name = damage_class.names |> list.first |> should.be_ok
  name.name |> should.equal("へんか")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")
}
