import gleam/list
import gleeunit/should
import tallgrass/client/item_category as client
import tallgrass/internal/item/category/category.{type ItemCategory}

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_countable
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("stat-boosts") |> should.be_ok |> should_be_countable
}

fn should_be_countable(category: ItemCategory) {
  category.id |> should.equal(1)
  category.name |> should.equal("stat-boosts")

  let item = category.items |> list.first |> should.be_ok
  item.name |> should.equal("guard-spec")
  item.url |> should.equal("https://pokeapi.co/api/v2/item/55/")

  let name = category.names |> list.first |> should.be_ok
  name.name |> should.equal("Stat boosts")
  name.language.name |> should.equal("en")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/9/")

  category.pocket.name |> should.equal("battle")
  category.pocket.url
  |> should.equal("https://pokeapi.co/api/v2/item-pocket/7/")
}
