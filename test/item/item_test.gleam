import gleam/list
import gleeunit/should
import tallgrass/item.{type Item}
import tallgrass/resource.{NamedResource}

pub fn fetch_test() {
  let resource =
    item.new()
    |> item.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  item.new()
  |> item.fetch_resource(resource)
  |> should.be_ok
  |> should_be_master_ball
}

pub fn fetch_by_id_test() {
  item.new()
  |> item.fetch_by_id(1)
  |> should.be_ok
  |> should_be_master_ball
}

pub fn fetch_by_name_test() {
  item.new()
  |> item.fetch_by_name("master-ball")
  |> should.be_ok
  |> should_be_master_ball
}

fn should_be_master_ball(item: Item) {
  item.id |> should.equal(1)
  item.name |> should.equal("master-ball")
  item.cost |> should.equal(0)

  item.fling_power |> should.be_none
  item.fling_effect |> should.be_none

  let assert NamedResource(url, name) =
    item.attributes |> list.first |> should.be_ok
  name |> should.equal("countable")
  url |> should.equal("https://pokeapi.co/api/v2/item-attribute/1/")

  let assert NamedResource(url, name) = item.category
  name |> should.equal("standard-balls")
  url |> should.equal("https://pokeapi.co/api/v2/item-category/34/")

  let effect = item.effect_entries |> list.first |> should.be_ok
  effect.effect
  |> should.equal(
    "Used in battle\n:   Catches a wild Pokémon without fail.\n\n    If used in a trainer battle, nothing happens and the ball is lost.",
  )
  effect.short_effect |> should.equal("Catches a wild Pokémon every time.")

  let assert NamedResource(url, name) = effect.language
  name |> should.equal("en")
  url |> should.equal("https://pokeapi.co/api/v2/language/9/")

  let flavor_text = item.flavor_text_entries |> list.first |> should.be_ok
  flavor_text.text
  |> should.equal("The best BALL that\ncatches a POKéMON\nwithout fail.")

  let assert NamedResource(url, name) = flavor_text.language
  name |> should.equal("en")
  url |> should.equal("https://pokeapi.co/api/v2/language/9/")

  let assert NamedResource(url, name) = flavor_text.version_group
  name |> should.equal("ruby-sapphire")
  url |> should.equal("https://pokeapi.co/api/v2/version-group/5/")

  let game_index = item.game_indices |> list.first |> should.be_ok
  game_index.index |> should.equal(1)

  let assert NamedResource(url, name) = game_index.generation
  name |> should.equal("generation-iii")
  url |> should.equal("https://pokeapi.co/api/v2/generation/3/")

  let name = item.names |> list.first |> should.be_ok
  name.name |> should.equal("マスターボール")

  let assert NamedResource(url, name) = name.language
  name |> should.equal("ja-Hrkt")
  url |> should.equal("https://pokeapi.co/api/v2/language/1/")

  item.held_by_pokemon |> list.is_empty |> should.be_true
  item.baby_trigger_for |> should.be_none
}
