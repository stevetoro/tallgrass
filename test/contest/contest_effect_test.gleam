import gleam/list
import gleeunit/should
import tallgrass/contest/effect

pub fn fetch_by_id_test() {
  let contest_effect = effect.fetch_by_id(1) |> should.be_ok
  contest_effect.id |> should.equal(1)
  contest_effect.appeal |> should.equal(4)
  contest_effect.jam |> should.equal(0)

  let effect = contest_effect.effect_entries |> list.first |> should.be_ok
  effect.effect
  |> should.equal("Gives a high number of appeal points wth no other effects.")
  effect.language.name |> should.equal("en")
  effect.language.url |> should.equal("https://pokeapi.co/api/v2/language/9/")

  let flavor_text =
    contest_effect.flavor_text_entries |> list.first |> should.be_ok
  flavor_text.text |> should.equal("A highly appealing move.")
  flavor_text.language.name |> should.equal("en")
  flavor_text.language.url
  |> should.equal("https://pokeapi.co/api/v2/language/9/")
}
