import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/cache.{NoCache}
import tallgrass/contest/contest_type.{type ContestType}
import tallgrass/resource.{Default, NamedResource}

pub fn fetch_test() {
  let response =
    contest_type.fetch(options: Default, cache: NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  contest_type.fetch_resource(resource, NoCache)
  |> should.be_ok
  |> should_be_cool
}

pub fn fetch_by_id_test() {
  contest_type.fetch_by_id(1, NoCache) |> should.be_ok |> should_be_cool
}

pub fn fetch_by_name_test() {
  contest_type.fetch_by_name("cool", NoCache) |> should.be_ok |> should_be_cool
}

fn should_be_cool(contest_type: ContestType) {
  contest_type.id |> should.equal(1)
  contest_type.name |> should.equal("cool")

  let assert NamedResource(url, name) = contest_type.berry_flavor
  name |> should.equal("spicy")
  url |> should.equal("https://pokeapi.co/api/v2/berry-flavor/1/")

  let name = contest_type.names |> should_have_english_name
  name.name |> should.equal("Cool")
}
