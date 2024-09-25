import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/client/resource.{NamedResource}
import tallgrass/move/learn_method.{type MoveLearnMethod}

pub fn fetch_test() {
  let resource =
    learn_method.new()
    |> learn_method.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  learn_method.new()
  |> learn_method.fetch_resource(resource)
  |> should.be_ok
  |> should_be_level_up
}

pub fn fetch_by_id_test() {
  learn_method.new()
  |> learn_method.fetch_by_id(1)
  |> should.be_ok
  |> should_be_level_up
}

pub fn fetch_by_name_test() {
  learn_method.new()
  |> learn_method.fetch_by_name("level-up")
  |> should.be_ok
  |> should_be_level_up
}

fn should_be_level_up(learn_method: MoveLearnMethod) {
  learn_method.id |> should.equal(1)
  learn_method.name |> should.equal("level-up")

  let description = learn_method.descriptions |> list.first |> should.be_ok
  description.text
  |> should.equal("Appris lorsqu’un Pokémon atteint un certain niveau.")

  let assert NamedResource(url, name) = description.language
  name |> should.equal("fr")
  url |> should.equal("https://pokeapi.co/api/v2/language/5/")

  let name = learn_method.names |> should_have_english_name
  name.name |> should.equal("Level up")

  let assert NamedResource(url, name) =
    learn_method.version_groups |> list.first |> should.be_ok
  name |> should.equal("red-blue")
  url |> should.equal("https://pokeapi.co/api/v2/version-group/1/")
}
