import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/client/resource.{NamedResource}
import tallgrass/item/attribute.{type ItemAttribute}

pub fn fetch_test() {
  let resource =
    attribute.new()
    |> attribute.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  attribute.new()
  |> attribute.fetch_resource(resource)
  |> should.be_ok
  |> should_be_countable
}

pub fn fetch_by_id_test() {
  attribute.new()
  |> attribute.fetch_by_id(1)
  |> should.be_ok
  |> should_be_countable
}

pub fn fetch_by_name_test() {
  attribute.new()
  |> attribute.fetch_by_name("countable")
  |> should.be_ok
  |> should_be_countable
}

fn should_be_countable(attribute: ItemAttribute) {
  attribute.id |> should.equal(1)
  attribute.name |> should.equal("countable")

  let description = attribute.descriptions |> list.first |> should.be_ok
  description.text |> should.equal("Has a count in the bag")

  let assert NamedResource(url, name) = description.language
  name |> should.equal("en")
  url |> should.equal("https://pokeapi.co/api/v2/language/9/")

  let assert NamedResource(url, name) =
    attribute.items |> list.first |> should.be_ok
  name |> should.equal("master-ball")
  url |> should.equal("https://pokeapi.co/api/v2/item/1/")

  let name = attribute.names |> should_have_english_name
  name.name |> should.equal("Countable")
}
