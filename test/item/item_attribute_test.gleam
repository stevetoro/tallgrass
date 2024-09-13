import gleam/list
import gleeunit/should
import tallgrass/client/item_attribute as client
import tallgrass/internal/item/attribute/attribute.{type ItemAttribute}

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_countable
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("countable") |> should.be_ok |> should_be_countable
}

fn should_be_countable(attribute: ItemAttribute) {
  attribute.id |> should.equal(1)
  attribute.name |> should.equal("countable")

  let description = attribute.descriptions |> list.first |> should.be_ok
  description.text |> should.equal("Has a count in the bag")
  description.language.name |> should.equal("en")
  description.language.url
  |> should.equal("https://pokeapi.co/api/v2/language/9/")

  let item = attribute.items |> list.first |> should.be_ok
  item.name |> should.equal("master-ball")
  item.url |> should.equal("https://pokeapi.co/api/v2/item/1/")

  let name = attribute.names |> list.first |> should.be_ok
  name.name |> should.equal("Countable")
  name.language.name |> should.equal("en")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/9/")
}
