import gleam/list
import gleeunit/should
import tallgrass/client/item_fling_effect as client
import tallgrass/internal/item/fling_effect/fling_effect.{type ItemFlingEffect}

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_badly_poison
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("badly-poison") |> should.be_ok |> should_be_badly_poison
}

fn should_be_badly_poison(fling_effect: ItemFlingEffect) {
  fling_effect.id |> should.equal(1)
  fling_effect.name |> should.equal("badly-poison")

  let effect = fling_effect.effect_entries |> list.first |> should.be_ok
  effect.effect |> should.equal("Badly poisons the target.")
  effect.language.name |> should.equal("en")
  effect.language.url |> should.equal("https://pokeapi.co/api/v2/language/9/")

  let item = fling_effect.items |> list.first |> should.be_ok
  item.name |> should.equal("toxic-orb")
  item.url |> should.equal("https://pokeapi.co/api/v2/item/249/")
}
