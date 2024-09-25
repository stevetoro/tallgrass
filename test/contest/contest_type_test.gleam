import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/common/resource.{NamedResource}
import tallgrass/contest/contest_type.{type ContestType}

pub fn fetch_test() {
  let resource =
    contest_type.new()
    |> contest_type.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  contest_type.new()
  |> contest_type.fetch_resource(resource)
  |> should.be_ok
  |> should_be_cool
}

pub fn fetch_by_id_test() {
  contest_type.new()
  |> contest_type.fetch_by_id(1)
  |> should.be_ok
  |> should_be_cool
}

pub fn fetch_by_name_test() {
  contest_type.new()
  |> contest_type.fetch_by_name("cool")
  |> should.be_ok
  |> should_be_cool
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
