import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/cache.{NoCache}
import tallgrass/move/battle_style.{type MoveBattleStyle}
import tallgrass/resource.{DefaultPagination}

pub fn fetch_test() {
  let response = battle_style.fetch(DefaultPagination, NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  battle_style.fetch_resource(resource, NoCache)
  |> should.be_ok
  |> should_be_attack
}

pub fn fetch_by_id_test() {
  battle_style.fetch_by_id(1, NoCache) |> should.be_ok |> should_be_attack
}

pub fn fetch_by_name_test() {
  battle_style.fetch_by_name("attack", NoCache)
  |> should.be_ok
  |> should_be_attack
}

fn should_be_attack(battle_style: MoveBattleStyle) {
  battle_style.id |> should.equal(1)
  battle_style.name |> should.equal("attack")

  let name = battle_style.names |> should_have_english_name
  name.name |> should.equal("Attack")
}
