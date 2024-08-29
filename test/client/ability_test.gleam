import api/ability.{type Ability}
import client/ability as client
import gleam/list
import gleeunit/should

pub fn fetch_by_id_test() {
  let assert Ok(ability) = client.fetch_by_id(1)
  ability |> should_be_stench
}

pub fn fetch_by_name_test() {
  let assert Ok(ability) = client.fetch_by_name("stench")
  ability |> should_be_stench
}

fn should_be_stench(ability: Ability) {
  ability.id |> should.equal(1)
  ability.name |> should.equal("stench")
  ability.is_main_series |> should.be_true

  ability.generation.name |> should.equal("generation-iii")
  ability.generation.url
  |> should.equal("https://pokeapi.co/api/v2/generation/3/")

  let assert Ok(name) = list.first(ability.names)

  name.name |> should.equal("あくしゅう")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")

  let assert Ok(effect) = ability.effect_entries |> list.first

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

  let assert Ok(flavor) = ability.flavor_text_entries |> list.first

  flavor.text
  |> should.equal("Helps repel wild POKéMON.")
  flavor.language.name |> should.equal("en")
  flavor.language.url |> should.equal("https://pokeapi.co/api/v2/language/9/")
  flavor.version_group.name |> should.equal("ruby-sapphire")
  flavor.version_group.url
  |> should.equal("https://pokeapi.co/api/v2/version-group/5/")

  let assert Ok(pokemon) = ability.pokemon |> list.first
  pokemon.is_hidden |> should.be_true
  pokemon.slot |> should.equal(3)
  pokemon.affordance.name |> should.equal("gloom")
  pokemon.affordance.url
  |> should.equal("https://pokeapi.co/api/v2/pokemon/44/")
}
