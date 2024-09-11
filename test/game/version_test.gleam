import gleam/list
import gleeunit/should
import tallgrass/client/version as client
import tallgrass/internal/game/version/version.{type Version}

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_red
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("red") |> should.be_ok |> should_be_red
}

fn should_be_red(version: Version) {
  version.id |> should.equal(1)
  version.name |> should.equal("red")

  let name = version.names |> list.first |> should.be_ok
  name.name |> should.equal("赤")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")

  version.version_group.name |> should.equal("red-blue")
  version.version_group.url
  |> should.equal("https://pokeapi.co/api/v2/version-group/1/")
}
