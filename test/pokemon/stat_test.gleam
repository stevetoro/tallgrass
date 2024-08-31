import gleam/list
import gleeunit/should
import pokemon/stat/client
import pokemon/stat/stat.{type Stat}

pub fn fetch_by_id_test() {
  client.fetch_by_id(2) |> should.be_ok |> should_be_attack
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("attack") |> should.be_ok |> should_be_attack
}

fn should_be_attack(stat: Stat) {
  stat.id |> should.equal(2)
  stat.name |> should.equal("attack")
  stat.game_index |> should.equal(2)
  stat.is_battle_only |> should.be_false

  stat.move_damage_class.name |> should.equal("physical")
  stat.move_damage_class.url
  |> should.equal("https://pokeapi.co/api/v2/move-damage-class/2/")

  let increasing_move =
    stat.affecting_moves.increase |> list.first |> should.be_ok
  increasing_move.change |> should.equal(2)
  increasing_move.affordance.name |> should.equal("swords-dance")
  increasing_move.affordance.url
  |> should.equal("https://pokeapi.co/api/v2/move/14/")

  let decreasing_move =
    stat.affecting_moves.decrease |> list.first |> should.be_ok
  decreasing_move.change |> should.equal(-1)
  decreasing_move.affordance.name |> should.equal("growl")
  decreasing_move.affordance.url
  |> should.equal("https://pokeapi.co/api/v2/move/45/")

  let increasing_nature =
    stat.affecting_natures.increase |> list.first |> should.be_ok
  increasing_nature.name |> should.equal("lonely")
  increasing_nature.url
  |> should.equal("https://pokeapi.co/api/v2/nature/6/")

  let decreasing_nature =
    stat.affecting_natures.decrease |> list.first |> should.be_ok
  decreasing_nature.name |> should.equal("bold")
  decreasing_nature.url
  |> should.equal("https://pokeapi.co/api/v2/nature/2/")

  let name = stat.names |> list.first |> should.be_ok
  name.name |> should.equal("こうげき")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")
}
