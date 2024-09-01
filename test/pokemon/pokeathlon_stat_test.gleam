import client/pokeathlon_stat as client
import gleam/list
import gleeunit/should
import pokegleam/pokemon/pokeathlon_stat/pokeathlon_stat.{type PokeathlonStat}

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_speed
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("speed") |> should.be_ok |> should_be_speed
}

fn should_be_speed(pokeathlon_stat: PokeathlonStat) {
  pokeathlon_stat.id |> should.equal(1)
  pokeathlon_stat.name |> should.equal("speed")

  let name = pokeathlon_stat.names |> list.first |> should.be_ok
  name.name |> should.equal("スピード")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")

  let increasing_nature =
    pokeathlon_stat.affecting_natures.increase |> list.first |> should.be_ok
  increasing_nature.max_change |> should.equal(2)
  increasing_nature.affordance.name |> should.equal("timid")
  increasing_nature.affordance.url
  |> should.equal("https://pokeapi.co/api/v2/nature/5/")

  let decreasing_nature =
    pokeathlon_stat.affecting_natures.decrease |> list.first |> should.be_ok
  decreasing_nature.max_change |> should.equal(-1)
  decreasing_nature.affordance.name |> should.equal("hardy")
  decreasing_nature.affordance.url
  |> should.equal("https://pokeapi.co/api/v2/nature/1/")
}
