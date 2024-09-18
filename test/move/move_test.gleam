import gleam/list
import gleeunit/should
import tallgrass/move.{type Move}

pub fn fetch_by_id_test() {
  move.fetch_by_id(1) |> should.be_ok |> should_be_pound
}

pub fn fetch_by_name_test() {
  move.fetch_by_name("pound") |> should.be_ok |> should_be_pound
}

fn should_be_pound(move: Move) {
  move.id |> should.equal(1)
  move.name |> should.equal("pound")
  move.accuracy |> should.equal(100)
  move.effect_chance |> should.be_none
  move.pp |> should.equal(35)
  move.priority |> should.equal(0)
  move.power |> should.equal(40)

  move.contest_type.name |> should.equal("tough")
  move.contest_type.url
  |> should.equal("https://pokeapi.co/api/v2/contest-type/5/")

  move.contest_effect.url
  |> should.equal("https://pokeapi.co/api/v2/contest-effect/1/")

  move.damage_class.name |> should.equal("physical")
  move.damage_class.url
  |> should.equal("https://pokeapi.co/api/v2/move-damage-class/2/")

  let effect = move.effect_entries |> list.first |> should.be_ok
  effect.effect |> should.equal("Inflicts regular damage.")
  effect.short_effect
  |> should.equal("Inflicts regular damage with no additional effect.")
  effect.language.name |> should.equal("en")
  effect.language.url |> should.equal("https://pokeapi.co/api/v2/language/9/")

  move.generation.name |> should.equal("generation-i")
  move.generation.url |> should.equal("https://pokeapi.co/api/v2/generation/1/")

  let name = move.names |> list.first |> should.be_ok
  name.name |> should.equal("はたく")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")

  move.super_contest_effect.url
  |> should.equal("https://pokeapi.co/api/v2/super-contest-effect/5/")

  move.target.name |> should.equal("selected-pokemon")
  move.target.url |> should.equal("https://pokeapi.co/api/v2/move-target/10/")

  move.pokemon_type.name |> should.equal("normal")
  move.pokemon_type.url |> should.equal("https://pokeapi.co/api/v2/type/1/")

  let pokemon = move.learned_by_pokemon |> list.first |> should.be_ok
  pokemon.name |> should.equal("clefairy")
  pokemon.url |> should.equal("https://pokeapi.co/api/v2/pokemon/35/")

  let flavor_text = move.flavor_text_entries |> list.first |> should.be_ok
  flavor_text.text
  |> should.equal("Pounds with fore­\nlegs or tail.")
  flavor_text.language.name |> should.equal("en")
  flavor_text.language.url
  |> should.equal("https://pokeapi.co/api/v2/language/9/")
  flavor_text.version_group.name |> should.equal("gold-silver")
  flavor_text.version_group.url
  |> should.equal("https://pokeapi.co/api/v2/version-group/3/")
}
