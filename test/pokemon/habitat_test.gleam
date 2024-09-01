import client/habitat as client
import gleam/list
import gleeunit/should
import internal/pokemon/habitat/habitat.{type Habitat}

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_cave
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("cave") |> should.be_ok |> should_be_cave
}

fn should_be_cave(habitat: Habitat) {
  habitat.id |> should.equal(1)
  habitat.name |> should.equal("cave")

  let name = habitat.names |> list.first |> should.be_ok
  name.name |> should.equal("grottes")
  name.language.name |> should.equal("fr")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/5/")
}
