import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/common/resource.{NamedResource}
import tallgrass/move/damage_class.{type MoveDamageClass}

pub fn fetch_test() {
  let resource =
    damage_class.new()
    |> damage_class.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  damage_class.new()
  |> damage_class.fetch_resource(resource)
  |> should.be_ok
  |> should_be_status
}

pub fn fetch_by_id_test() {
  damage_class.new()
  |> damage_class.fetch_by_id(1)
  |> should.be_ok
  |> should_be_status
}

pub fn fetch_by_name_test() {
  damage_class.new()
  |> damage_class.fetch_by_name("status")
  |> should.be_ok
  |> should_be_status
}

fn should_be_status(damage_class: MoveDamageClass) {
  damage_class.id |> should.equal(1)
  damage_class.name |> should.equal("status")

  let description = damage_class.descriptions |> list.first |> should.be_ok
  description.text |> should.equal("ダメージない")

  let assert NamedResource(url, name) = description.language
  name |> should.equal("ja-Hrkt")
  url |> should.equal("https://pokeapi.co/api/v2/language/1/")

  let assert NamedResource(url, name) =
    damage_class.moves |> list.first |> should.be_ok
  name |> should.equal("swords-dance")
  url |> should.equal("https://pokeapi.co/api/v2/move/14/")

  let name = damage_class.names |> should_have_english_name
  name.name |> should.equal("status")
}
