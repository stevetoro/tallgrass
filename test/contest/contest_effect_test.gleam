import gleam/list
import gleeunit/should
import tallgrass/common/resource.{NamedResource}
import tallgrass/contest/effect.{type ContestEffect}

pub fn fetch_test() {
  let resource =
    effect.new()
    |> effect.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  effect.new()
  |> effect.fetch_resource(resource)
  |> should.be_ok
  |> should_be_contest_effect
}

pub fn fetch_by_id_test() {
  effect.new()
  |> effect.fetch_by_id(1)
  |> should.be_ok
  |> should_be_contest_effect
}

fn should_be_contest_effect(contest_effect: ContestEffect) {
  contest_effect.id |> should.equal(1)
  contest_effect.appeal |> should.equal(4)
  contest_effect.jam |> should.equal(0)

  let effect = contest_effect.effect_entries |> list.first |> should.be_ok
  effect.effect
  |> should.equal("Gives a high number of appeal points wth no other effects.")

  let assert NamedResource(url, name) = effect.language
  name |> should.equal("en")
  url |> should.equal("https://pokeapi.co/api/v2/language/9/")

  let flavor_text =
    contest_effect.flavor_text_entries |> list.first |> should.be_ok
  flavor_text.text |> should.equal("A highly appealing move.")

  let assert NamedResource(url, name) = flavor_text.language
  name |> should.equal("en")
  url |> should.equal("https://pokeapi.co/api/v2/language/9/")
}
