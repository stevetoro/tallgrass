import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/cache.{NoCache}
import tallgrass/pokemon/pokeathlon_stat.{type PokeathlonStat}
import tallgrass/resource.{Default, NamedResource}

pub fn fetch_test() {
  let response =
    pokeathlon_stat.fetch(options: Default, cache: NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  pokeathlon_stat.fetch_resource(resource, NoCache)
  |> should.be_ok
  |> should_be_speed
}

pub fn fetch_by_id_test() {
  pokeathlon_stat.fetch_by_id(1, NoCache) |> should.be_ok |> should_be_speed
}

pub fn fetch_by_name_test() {
  pokeathlon_stat.fetch_by_name("speed", NoCache)
  |> should.be_ok
  |> should_be_speed
}

fn should_be_speed(pokeathlon_stat: PokeathlonStat) {
  pokeathlon_stat.id |> should.equal(1)
  pokeathlon_stat.name |> should.equal("speed")

  let name = pokeathlon_stat.names |> should_have_english_name
  name.name |> should.equal("Speed")

  let increasing_nature =
    pokeathlon_stat.affecting_natures.increase |> list.first |> should.be_ok
  increasing_nature.max_change |> should.equal(2)

  let assert NamedResource(url, name) = increasing_nature.nature
  name |> should.equal("timid")
  url |> should.equal("https://pokeapi.co/api/v2/nature/5/")

  let decreasing_nature =
    pokeathlon_stat.affecting_natures.decrease |> list.first |> should.be_ok
  decreasing_nature.max_change |> should.equal(-1)

  let assert NamedResource(url, name) = decreasing_nature.nature
  name |> should.equal("hardy")
  url |> should.equal("https://pokeapi.co/api/v2/nature/1/")
}
