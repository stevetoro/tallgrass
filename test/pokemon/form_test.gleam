import gleam/list
import gleeunit/should
import tallgrass/client/form as client
import tallgrass/internal/pokemon/form/form.{type Form}

pub fn fetch_by_id_test() {
  client.fetch_by_id(10_041) |> should.be_ok |> should_be_arceus_bug
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("arceus-bug") |> should.be_ok |> should_be_arceus_bug
}

fn should_be_arceus_bug(form: Form) {
  form.id |> should.equal(10_041)
  form.name |> should.equal("arceus-bug")
  form.order |> should.equal(649)
  form.form_order |> should.equal(7)
  form.is_default |> should.be_false
  form.is_battle_only |> should.be_false
  form.is_mega |> should.be_false
  form.form_name |> should.equal("bug")

  form.pokemon.name |> should.equal("arceus")
  form.pokemon.url |> should.equal("https://pokeapi.co/api/v2/pokemon/493/")

  let type_ = form.types |> list.first |> should.be_ok
  type_.slot |> should.equal(1)
  type_.affordance.name |> should.equal("bug")
  type_.affordance.url |> should.equal("https://pokeapi.co/api/v2/type/7/")

  form.version_group.name |> should.equal("diamond-pearl")
  form.version_group.url
  |> should.equal("https://pokeapi.co/api/v2/version-group/8/")
}
