import gleam/list
import gleeunit/should
import tallgrass/game/version_group.{type VersionGroup}

pub fn fetch_by_id_test() {
  version_group.fetch_by_id(1) |> should.be_ok |> should_be_red_blue
}

pub fn fetch_by_name_test() {
  version_group.fetch_by_name("red-blue") |> should.be_ok |> should_be_red_blue
}

fn should_be_red_blue(version_group: VersionGroup) {
  version_group.id |> should.equal(1)
  version_group.name |> should.equal("red-blue")
  version_group.order |> should.equal(1)

  version_group.generation.name |> should.equal("generation-i")
  version_group.generation.url
  |> should.equal("https://pokeapi.co/api/v2/generation/1/")

  let move_learn_method =
    version_group.move_learn_methods |> list.first |> should.be_ok
  move_learn_method.name |> should.equal("level-up")
  move_learn_method.url
  |> should.equal("https://pokeapi.co/api/v2/move-learn-method/1/")

  let pokedex = version_group.pokedexes |> list.first |> should.be_ok
  pokedex.name |> should.equal("kanto")
  pokedex.url
  |> should.equal("https://pokeapi.co/api/v2/pokedex/2/")

  let region = version_group.regions |> list.first |> should.be_ok
  region.name |> should.equal("kanto")
  region.url
  |> should.equal("https://pokeapi.co/api/v2/region/1/")

  let version = version_group.versions |> list.first |> should.be_ok
  version.name |> should.equal("red")
  version.url
  |> should.equal("https://pokeapi.co/api/v2/version/1/")
}
