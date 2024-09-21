import gleam/list
import gleam/option.{None}
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/pokemon/ability.{type Ability}
import tallgrass/resource.{NamedResource}

pub fn fetch_test() {
  let response = ability.fetch(options: None) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  ability.fetch_resource(resource) |> should.be_ok |> should_be_stench
}

pub fn fetch_by_id_test() {
  ability.fetch_by_id(1) |> should.be_ok |> should_be_stench
}

pub fn fetch_by_name_test() {
  ability.fetch_by_name("stench") |> should.be_ok |> should_be_stench
}

fn should_be_stench(ability: Ability) {
  ability.id |> should.equal(1)
  ability.name |> should.equal("stench")
  ability.is_main_series |> should.be_true

  let assert NamedResource(url, name) = ability.generation
  name |> should.equal("generation-iii")
  url |> should.equal("https://pokeapi.co/api/v2/generation/3/")

  let name = ability.names |> should_have_english_name
  name.name |> should.equal("Stench")

  let effect = ability.effect_entries |> list.first |> should.be_ok
  effect.effect
  |> should.equal(
    "Attacken die Schaden verursachen haben mit jedem Treffer eine 10% Chance das Ziel zurückschrecken zu lassen, wenn die Attacke dies nicht bereits als Nebeneffekt hat.\n\nDer Effekt stapelt nicht mit dem von getragenen Items.\n\nAußerhalb vom Kampf: Wenn ein Pokémon mit dieser Fähigkeit an erster Stelle im Team steht, tauchen wilde Pokémon nur halb so oft auf.",
  )
  effect.short_effect
  |> should.equal(
    "Mit jedem Treffer besteht eine 10% Chance das Ziel zurückschrecken zu lassen.",
  )

  let assert NamedResource(url, name) = effect.language
  name |> should.equal("de")
  url |> should.equal("https://pokeapi.co/api/v2/language/6/")

  let flavor_text =
    ability.flavor_text_entries
    |> list.filter(fn(flavor_text) {
      let assert NamedResource(_, name) = flavor_text.language
      name == "en"
    })
    |> list.first
    |> should.be_ok
  flavor_text.text |> should.equal("Helps repel wild POKéMON.")

  let assert NamedResource(url, name) = flavor_text.language
  name |> should.equal("en")
  url |> should.equal("https://pokeapi.co/api/v2/language/9/")

  let assert NamedResource(url, name) = flavor_text.version_group
  name |> should.equal("ruby-sapphire")
  url |> should.equal("https://pokeapi.co/api/v2/version-group/5/")

  let pokemon = ability.pokemon |> list.first |> should.be_ok
  pokemon.is_hidden |> should.be_true
  pokemon.slot |> should.equal(3)

  let assert NamedResource(url, name) = pokemon.pokemon
  name |> should.equal("gloom")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon/44/")
}
