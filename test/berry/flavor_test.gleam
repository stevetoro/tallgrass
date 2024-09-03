import gleam/list
import gleeunit/should
import tallgrass/client/berry_flavor as client
import tallgrass/internal/berry/flavor/flavor.{type Flavor}

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_spicy
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("spicy") |> should.be_ok |> should_be_spicy
}

fn should_be_spicy(flavor: Flavor) {
  flavor.id |> should.equal(1)
  flavor.name |> should.equal("spicy")

  let berry = flavor.berries |> list.first |> should.be_ok
  berry.potency |> should.equal(10)
  berry.berry.name |> should.equal("rowap")
  berry.berry.url |> should.equal("https://pokeapi.co/api/v2/berry/64/")

  flavor.contest_type.name |> should.equal("cool")
  flavor.contest_type.url
  |> should.equal("https://pokeapi.co/api/v2/contest-type/1/")

  let name = flavor.names |> list.first |> should.be_ok
  name.name |> should.equal("からい")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")
}
