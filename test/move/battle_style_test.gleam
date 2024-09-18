import gleam/list
import gleeunit/should
import tallgrass/move/battle_style.{type MoveBattleStyle}

pub fn fetch_by_id_test() {
  battle_style.fetch_by_id(1) |> should.be_ok |> should_be_attack
}

pub fn fetch_by_name_test() {
  battle_style.fetch_by_name("attack") |> should.be_ok |> should_be_attack
}

fn should_be_attack(battle_style: MoveBattleStyle) {
  battle_style.id |> should.equal(1)
  battle_style.name |> should.equal("attack")

  let name = battle_style.names |> list.first |> should.be_ok
  name.name |> should.equal("Attaque")
  name.language.name |> should.equal("fr")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/5/")
}
