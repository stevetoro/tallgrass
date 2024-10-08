import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/common/resource.{NamedResource}
import tallgrass/item/category.{type ItemCategory}

pub fn fetch_test() {
  let resource =
    category.new()
    |> category.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  category.new()
  |> category.fetch_resource(resource)
  |> should.be_ok
  |> should_be_stat_boosts
}

pub fn fetch_by_id_test() {
  category.new()
  |> category.fetch_by_id(1)
  |> should.be_ok
  |> should_be_stat_boosts
}

pub fn fetch_by_name_test() {
  category.new()
  |> category.fetch_by_name("stat-boosts")
  |> should.be_ok
  |> should_be_stat_boosts
}

fn should_be_stat_boosts(category: ItemCategory) {
  category.id |> should.equal(1)
  category.name |> should.equal("stat-boosts")

  let assert NamedResource(url, name) =
    category.items |> list.first |> should.be_ok
  name |> should.equal("guard-spec")
  url |> should.equal("https://pokeapi.co/api/v2/item/55/")

  let name = category.names |> should_have_english_name
  name.name |> should.equal("Stat boosts")

  let assert NamedResource(url, name) = category.pocket
  name |> should.equal("battle")
  url |> should.equal("https://pokeapi.co/api/v2/item-pocket/7/")
}
