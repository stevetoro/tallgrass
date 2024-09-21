import gleam/list
import gleeunit/should
import tallgrass/contest/super_effect
import tallgrass/resource.{NamedResource}

pub fn fetch_by_id_test() {
  let super_contest_effect = super_effect.fetch_by_id(1) |> should.be_ok
  super_contest_effect.id |> should.equal(1)
  super_contest_effect.appeal |> should.equal(2)

  let flavor_text =
    super_contest_effect.flavor_text_entries |> list.first |> should.be_ok
  flavor_text.text
  |> should.equal("Enables the user to perform first in the next turn.")

  let assert NamedResource(url, name) = flavor_text.language
  name |> should.equal("en")
  url |> should.equal("https://pokeapi.co/api/v2/language/9/")

  let assert NamedResource(url, name) =
    super_contest_effect.moves |> list.first |> should.be_ok
  name |> should.equal("agility")
  url |> should.equal("https://pokeapi.co/api/v2/move/97/")
}
