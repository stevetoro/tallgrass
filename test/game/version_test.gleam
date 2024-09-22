import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/cache.{NoCache}
import tallgrass/game/version.{type Version}
import tallgrass/resource.{Default, NamedResource}

pub fn fetch_test() {
  let response = version.fetch(options: Default, cache: NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  version.fetch_resource(resource, NoCache) |> should.be_ok |> should_be_red
}

pub fn fetch_by_id_test() {
  version.fetch_by_id(1, NoCache) |> should.be_ok |> should_be_red
}

pub fn fetch_by_name_test() {
  version.fetch_by_name("red", NoCache) |> should.be_ok |> should_be_red
}

fn should_be_red(version: Version) {
  version.id |> should.equal(1)
  version.name |> should.equal("red")

  let name = version.names |> should_have_english_name
  name.name |> should.equal("Red")

  let assert NamedResource(url, name) = version.version_group
  name |> should.equal("red-blue")
  url |> should.equal("https://pokeapi.co/api/v2/version-group/1/")
}
