import gleam/list
import gleeunit/should
import tallgrass/item/pocket.{type ItemPocket}

pub fn fetch_by_id_test() {
  pocket.fetch_by_id(1) |> should.be_ok |> should_be_misc
}

pub fn fetch_by_name_test() {
  pocket.fetch_by_name("misc") |> should.be_ok |> should_be_misc
}

fn should_be_misc(pocket: ItemPocket) {
  pocket.id |> should.equal(1)
  pocket.name |> should.equal("misc")

  let category = pocket.categories |> list.first |> should.be_ok
  category.name |> should.equal("collectibles")
  category.url |> should.equal("https://pokeapi.co/api/v2/item-category/9/")

  let name = pocket.names |> list.first |> should.be_ok
  name.name |> should.equal("道具")
  name.language.name |> should.equal("zh-Hant")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/4/")
}
