import gleam/list
import gleeunit/should
import tallgrass/pokemon/ability.{type Ability}

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

  ability.generation.name |> should.equal("generation-iii")
  ability.generation.url
  |> should.equal("https://pokeapi.co/api/v2/generation/3/")

  let name = ability.names |> list.first |> should.be_ok
  name.name |> should.equal("あくしゅう")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")

  let effect = ability.effect_entries |> list.first |> should.be_ok
  effect.effect
  |> should.equal(
    "Attacken die Schaden verursachen haben mit jedem Treffer eine 10% Chance das Ziel zurückschrecken zu lassen, wenn die Attacke dies nicht bereits als Nebeneffekt hat.\n\nDer Effekt stapelt nicht mit dem von getragenen Items.\n\nAußerhalb vom Kampf: Wenn ein Pokémon mit dieser Fähigkeit an erster Stelle im Team steht, tauchen wilde Pokémon nur halb so oft auf.",
  )
  effect.short_effect
  |> should.equal(
    "Mit jedem Treffer besteht eine 10% Chance das Ziel zurückschrecken zu lassen.",
  )
  effect.language.name |> should.equal("de")
  effect.language.url |> should.equal("https://pokeapi.co/api/v2/language/6/")

  let flavor = ability.flavor_text_entries |> list.first |> should.be_ok
  flavor.text |> should.equal("Helps repel wild POKéMON.")
  flavor.language.name |> should.equal("en")
  flavor.language.url |> should.equal("https://pokeapi.co/api/v2/language/9/")
  flavor.version_group.name |> should.equal("ruby-sapphire")
  flavor.version_group.url
  |> should.equal("https://pokeapi.co/api/v2/version-group/5/")

  let pokemon = ability.pokemon |> list.first |> should.be_ok
  pokemon.is_hidden |> should.be_true
  pokemon.slot |> should.equal(3)
  pokemon.pokemon.name |> should.equal("gloom")
  pokemon.pokemon.url
  |> should.equal("https://pokeapi.co/api/v2/pokemon/44/")
}
