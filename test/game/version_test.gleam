import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/common/resource.{NamedResource}
import tallgrass/game/version.{type Version}

pub fn fetch_test() {
  let resource =
    version.new()
    |> version.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  version.new()
  |> version.fetch_resource(resource)
  |> should.be_ok
  |> should_be_red
}

pub fn fetch_by_id_test() {
  version.new()
  |> version.fetch_by_id(1)
  |> should.be_ok
  |> should_be_red
}

pub fn fetch_by_name_test() {
  version.new()
  |> version.fetch_by_name("red")
  |> should.be_ok
  |> should_be_red
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
