import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/pokemon/pokeathlon_stat.{type PokeathlonStat}
import tallgrass/client/resource.{NamedResource}

pub fn fetch_test() {
  let resource =
    pokeathlon_stat.new()
    |> pokeathlon_stat.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  pokeathlon_stat.new()
  |> pokeathlon_stat.fetch_resource(resource)
  |> should.be_ok
  |> should_be_speed
}

pub fn fetch_by_id_test() {
  pokeathlon_stat.new()
  |> pokeathlon_stat.fetch_by_id(1)
  |> should.be_ok
  |> should_be_speed
}

pub fn fetch_by_name_test() {
  pokeathlon_stat.new()
  |> pokeathlon_stat.fetch_by_name("speed")
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
