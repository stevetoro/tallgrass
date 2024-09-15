import gleam/list
import gleeunit/should
import tallgrass/item.{type Item}

pub fn fetch_by_id_test() {
  item.fetch_by_id(1) |> should.be_ok |> should_be_master_ball
}

pub fn fetch_by_name_test() {
  item.fetch_by_name("master-ball") |> should.be_ok |> should_be_master_ball
}

fn should_be_master_ball(item: Item) {
  item.id |> should.equal(1)
  item.name |> should.equal("master-ball")
  item.cost |> should.equal(0)

  item.fling_power |> should.be_none
  item.fling_effect |> should.be_none

  let attribute = item.attributes |> list.first |> should.be_ok
  attribute.name |> should.equal("countable")
  attribute.url |> should.equal("https://pokeapi.co/api/v2/item-attribute/1/")

  item.category.name |> should.equal("standard-balls")
  item.category.url
  |> should.equal("https://pokeapi.co/api/v2/item-category/34/")

  let effect = item.effect_entries |> list.first |> should.be_ok
  effect.effect
  |> should.equal(
    "Used in battle\n:   Catches a wild Pokémon without fail.\n\n    If used in a trainer battle, nothing happens and the ball is lost.",
  )
  effect.short_effect |> should.equal("Catches a wild Pokémon every time.")
  effect.language.name |> should.equal("en")
  effect.language.url |> should.equal("https://pokeapi.co/api/v2/language/9/")

  let flavor_text = item.flavor_text_entries |> list.first |> should.be_ok
  flavor_text.text
  |> should.equal("The best BALL that\ncatches a POKéMON\nwithout fail.")
  flavor_text.language.name |> should.equal("en")
  flavor_text.language.url
  |> should.equal("https://pokeapi.co/api/v2/language/9/")
  flavor_text.version_group.name |> should.equal("ruby-sapphire")
  flavor_text.version_group.url
  |> should.equal("https://pokeapi.co/api/v2/version-group/5/")

  let game_index = item.game_indices |> list.first |> should.be_ok
  game_index.index |> should.equal(1)
  game_index.generation.name |> should.equal("generation-iii")
  game_index.generation.url
  |> should.equal("https://pokeapi.co/api/v2/generation/3/")

  let name = item.names |> list.first |> should.be_ok
  name.name |> should.equal("マスターボール")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")

  item.held_by_pokemon |> list.is_empty |> should.be_true

  item.baby_trigger_for |> should.be_none
}
