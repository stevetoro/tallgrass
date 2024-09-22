import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/cache.{NoCache}
import tallgrass/item/category.{type ItemCategory}
import tallgrass/resource.{Default, NamedResource}

pub fn fetch_test() {
  let response =
    category.fetch(options: Default, cache: NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  category.fetch_resource(resource, NoCache)
  |> should.be_ok
  |> should_be_stat_boosts
}

pub fn fetch_by_id_test() {
  category.fetch_by_id(1, NoCache) |> should.be_ok |> should_be_stat_boosts
}

pub fn fetch_by_name_test() {
  category.fetch_by_name("stat-boosts", NoCache)
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
