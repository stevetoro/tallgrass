import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/pokemon/habitat.{type Habitat}

pub fn fetch_test() {
  let resource =
    habitat.new()
    |> habitat.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  habitat.new()
  |> habitat.fetch_resource(resource)
  |> should.be_ok
  |> should_be_cave
}

pub fn fetch_by_id_test() {
  habitat.new()
  |> habitat.fetch_by_id(1)
  |> should.be_ok
  |> should_be_cave
}

pub fn fetch_by_name_test() {
  habitat.new()
  |> habitat.fetch_by_name("cave")
  |> should.be_ok
  |> should_be_cave
}

fn should_be_cave(habitat: Habitat) {
  habitat.id |> should.equal(1)
  habitat.name |> should.equal("cave")

  let name = habitat.names |> should_have_english_name
  name.name |> should.equal("cave")
}
