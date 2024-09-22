import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/berry/flavor.{type BerryFlavor}
import tallgrass/cache.{NoCache}
import tallgrass/resource.{DefaultPagination, NamedResource}

pub fn fetch_test() {
  let response = flavor.fetch(DefaultPagination, NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  flavor.fetch_resource(resource, NoCache) |> should.be_ok |> should_be_spicy
}

pub fn fetch_by_id_test() {
  flavor.fetch_by_id(1, NoCache) |> should.be_ok |> should_be_spicy
}

pub fn fetch_by_name_test() {
  flavor.fetch_by_name("spicy", NoCache) |> should.be_ok |> should_be_spicy
}

fn should_be_spicy(flavor: BerryFlavor) {
  flavor.id |> should.equal(1)
  flavor.name |> should.equal("spicy")

  let berry = flavor.berries |> list.first |> should.be_ok
  berry.potency |> should.equal(10)

  let assert NamedResource(url, name) = berry.berry
  name |> should.equal("rowap")
  url |> should.equal("https://pokeapi.co/api/v2/berry/64/")

  let assert NamedResource(url, name) = flavor.contest_type
  name |> should.equal("cool")
  url |> should.equal("https://pokeapi.co/api/v2/contest-type/1/")

  let name = flavor.names |> should_have_english_name
  name.name |> should.equal("Spicy")
}
