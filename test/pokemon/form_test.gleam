import gleam/list
import gleeunit/should
import tallgrass/client.{with_pagination}
import tallgrass/page.{Paginate}
import tallgrass/pokemon/form.{type PokemonForm}
import tallgrass/resource.{NamedResource}

pub fn fetch_test() {
  let resource =
    form.new()
    |> with_pagination(Paginate(limit: 1, offset: 1065))
    |> form.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  form.new()
  |> form.fetch_resource(resource)
  |> should.be_ok
  |> should_be_arceus_bug
}

pub fn fetch_by_id_test() {
  form.new()
  |> form.fetch_by_id(10_041)
  |> should.be_ok
  |> should_be_arceus_bug
}

pub fn fetch_by_name_test() {
  form.new()
  |> form.fetch_by_name("arceus-bug")
  |> should.be_ok
  |> should_be_arceus_bug
}

fn should_be_arceus_bug(form: PokemonForm) {
  form.id |> should.equal(10_041)
  form.name |> should.equal("arceus-bug")
  form.order |> should.equal(649)
  form.form_order |> should.equal(7)
  form.is_default |> should.be_false
  form.is_battle_only |> should.be_false
  form.is_mega |> should.be_false
  form.form_name |> should.equal("bug")

  let assert NamedResource(url, name) = form.pokemon
  name |> should.equal("arceus")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon/493/")

  let pokemon_type = form.types |> list.first |> should.be_ok
  pokemon_type.slot |> should.equal(1)

  let assert NamedResource(url, name) = pokemon_type.pokemon_type
  name |> should.equal("bug")
  url |> should.equal("https://pokeapi.co/api/v2/type/7/")

  let assert NamedResource(url, name) = form.version_group
  name |> should.equal("diamond-pearl")
  url |> should.equal("https://pokeapi.co/api/v2/version-group/8/")
}
