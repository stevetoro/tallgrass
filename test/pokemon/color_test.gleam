import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/cache.{NoCache}
import tallgrass/pokemon/color.{type PokemonColor}
import tallgrass/resource.{Default}

pub fn fetch_test() {
  let response = color.fetch(options: Default, cache: NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  color.fetch_resource(resource, NoCache) |> should.be_ok |> should_be_black
}

pub fn fetch_by_id_test() {
  color.fetch_by_id(1, NoCache) |> should.be_ok |> should_be_black
}

pub fn fetch_by_name_test() {
  color.fetch_by_name("black", NoCache) |> should.be_ok |> should_be_black
}

fn should_be_black(color: PokemonColor) {
  color.id |> should.equal(1)
  color.name |> should.equal("black")

  let name = color.names |> should_have_english_name
  name.name |> should.equal("Black")
}
