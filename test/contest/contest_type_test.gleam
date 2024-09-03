import gleam/list
import gleeunit/should
import tallgrass/client/contest_type as client
import tallgrass/internal/contest/contest_type/contest_type.{type ContestType}

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_cool
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("cool") |> should.be_ok |> should_be_cool
}

fn should_be_cool(contest_type: ContestType) {
  contest_type.id |> should.equal(1)
  contest_type.name |> should.equal("cool")

  contest_type.berry_flavor.name |> should.equal("spicy")
  contest_type.berry_flavor.url
  |> should.equal("https://pokeapi.co/api/v2/berry-flavor/1/")

  let name = contest_type.names |> list.first |> should.be_ok
  name.name |> should.equal("かっこよさ")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")
}
