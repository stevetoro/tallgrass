import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/common/resource.{NamedResource}
import tallgrass/move.{type Move}

pub fn fetch_test() {
  let resource =
    move.new()
    |> move.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  move.new()
  |> move.fetch_resource(resource)
  |> should.be_ok
  |> should_be_pound
}

pub fn fetch_by_id_test() {
  move.new()
  |> move.fetch_by_id(1)
  |> should.be_ok
  |> should_be_pound
}

pub fn fetch_by_name_test() {
  move.new()
  |> move.fetch_by_name("pound")
  |> should.be_ok
  |> should_be_pound
}

fn should_be_pound(move: Move) {
  move.id |> should.equal(1)
  move.name |> should.equal("pound")
  move.accuracy |> should.equal(100)
  move.effect_chance |> should.be_none
  move.pp |> should.equal(35)
  move.priority |> should.equal(0)
  move.power |> should.equal(40)

  let assert NamedResource(url, name) = move.contest_type
  name |> should.equal("tough")
  url |> should.equal("https://pokeapi.co/api/v2/contest-type/5/")

  move.contest_effect.url
  |> should.equal("https://pokeapi.co/api/v2/contest-effect/1/")

  let assert NamedResource(url, name) = move.damage_class
  name |> should.equal("physical")
  url |> should.equal("https://pokeapi.co/api/v2/move-damage-class/2/")

  let effect = move.effect_entries |> list.first |> should.be_ok
  effect.effect |> should.equal("Inflicts regular damage.")
  effect.short_effect
  |> should.equal("Inflicts regular damage with no additional effect.")

  let assert NamedResource(url, name) = effect.language
  name |> should.equal("en")
  url |> should.equal("https://pokeapi.co/api/v2/language/9/")

  let assert NamedResource(url, name) = move.generation
  name |> should.equal("generation-i")
  url |> should.equal("https://pokeapi.co/api/v2/generation/1/")

  let name = move.names |> should_have_english_name
  name.name |> should.equal("Pound")

  move.super_contest_effect.url
  |> should.equal("https://pokeapi.co/api/v2/super-contest-effect/5/")

  let assert NamedResource(url, name) = move.target
  name |> should.equal("selected-pokemon")
  url |> should.equal("https://pokeapi.co/api/v2/move-target/10/")

  let assert NamedResource(url, name) = move.pokemon_type
  name |> should.equal("normal")
  url |> should.equal("https://pokeapi.co/api/v2/type/1/")

  let assert NamedResource(url, name) =
    move.learned_by_pokemon |> list.first |> should.be_ok
  name |> should.equal("clefairy")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon/35/")

  let flavor_text = move.flavor_text_entries |> list.first |> should.be_ok
  flavor_text.text
  |> should.equal("Pounds with fore­\nlegs or tail.")

  let assert NamedResource(url, name) = flavor_text.language
  name |> should.equal("en")
  url |> should.equal("https://pokeapi.co/api/v2/language/9/")

  let assert NamedResource(url, name) = flavor_text.version_group
  name |> should.equal("gold-silver")
  url |> should.equal("https://pokeapi.co/api/v2/version-group/3/")
}
