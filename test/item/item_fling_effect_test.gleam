import gleam/list
import gleeunit/should
import tallgrass/cache.{NoCache}
import tallgrass/item/fling_effect.{type ItemFlingEffect}
import tallgrass/resource.{DefaultPagination, NamedResource}

pub fn fetch_test() {
  let response = fling_effect.fetch(DefaultPagination, NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  fling_effect.fetch_resource(resource, NoCache)
  |> should.be_ok
  |> should_be_badly_poison
}

pub fn fetch_by_id_test() {
  fling_effect.fetch_by_id(1, NoCache) |> should.be_ok |> should_be_badly_poison
}

pub fn fetch_by_name_test() {
  fling_effect.fetch_by_name("badly-poison", NoCache)
  |> should.be_ok
  |> should_be_badly_poison
}

fn should_be_badly_poison(fling_effect: ItemFlingEffect) {
  fling_effect.id |> should.equal(1)
  fling_effect.name |> should.equal("badly-poison")

  let effect = fling_effect.effect_entries |> list.first |> should.be_ok
  effect.effect |> should.equal("Badly poisons the target.")

  let assert NamedResource(url, name) = effect.language
  name |> should.equal("en")
  url |> should.equal("https://pokeapi.co/api/v2/language/9/")

  let assert NamedResource(url, name) =
    fling_effect.items |> list.first |> should.be_ok
  name |> should.equal("toxic-orb")
  url |> should.equal("https://pokeapi.co/api/v2/item/249/")
}
