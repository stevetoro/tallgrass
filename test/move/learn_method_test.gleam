import gleam/list
import gleeunit/should
import tallgrass/move/learn_method.{type MoveLearnMethod}

pub fn fetch_by_id_test() {
  learn_method.fetch_by_id(1) |> should.be_ok |> should_be_level_up
}

pub fn fetch_by_name_test() {
  learn_method.fetch_by_name("level-up") |> should.be_ok |> should_be_level_up
}

fn should_be_level_up(learn_method: MoveLearnMethod) {
  learn_method.id |> should.equal(1)
  learn_method.name |> should.equal("level-up")

  let description = learn_method.descriptions |> list.first |> should.be_ok
  description.text
  |> should.equal("Appris lorsqu’un Pokémon atteint un certain niveau.")
  description.language.name |> should.equal("fr")
  description.language.url
  |> should.equal("https://pokeapi.co/api/v2/language/5/")

  let name = learn_method.names |> list.first |> should.be_ok
  name.name |> should.equal("Montée de niveau")
  name.language.name |> should.equal("fr")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/5/")

  let version_group = learn_method.version_groups |> list.first |> should.be_ok
  version_group.name |> should.equal("red-blue")
  version_group.url
  |> should.equal("https://pokeapi.co/api/v2/version-group/1/")
}
