import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/cache.{NoCache}
import tallgrass/item/pocket.{type ItemPocket}
import tallgrass/resource.{DefaultPagination, NamedResource}

pub fn fetch_test() {
  let response = pocket.fetch(DefaultPagination, NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  pocket.fetch_resource(resource, NoCache) |> should.be_ok |> should_be_misc
}

pub fn fetch_by_id_test() {
  pocket.fetch_by_id(1, NoCache) |> should.be_ok |> should_be_misc
}

pub fn fetch_by_name_test() {
  pocket.fetch_by_name("misc", NoCache) |> should.be_ok |> should_be_misc
}

fn should_be_misc(pocket: ItemPocket) {
  pocket.id |> should.equal(1)
  pocket.name |> should.equal("misc")

  let assert NamedResource(url, name) =
    pocket.categories |> list.first |> should.be_ok
  name |> should.equal("collectibles")
  url |> should.equal("https://pokeapi.co/api/v2/item-category/9/")

  let name = pocket.names |> should_have_english_name
  name.name |> should.equal("Items")
}
