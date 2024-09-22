import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/cache.{NoCache}
import tallgrass/pokemon/stat.{type Stat}
import tallgrass/resource.{NamedResource, Offset}

pub fn fetch_test() {
  let response = stat.fetch(Offset(1), NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  stat.fetch_resource(resource, NoCache) |> should.be_ok |> should_be_attack
}

pub fn fetch_by_id_test() {
  stat.fetch_by_id(2, NoCache) |> should.be_ok |> should_be_attack
}

pub fn fetch_by_name_test() {
  stat.fetch_by_name("attack", NoCache) |> should.be_ok |> should_be_attack
}

fn should_be_attack(stat: Stat) {
  stat.id |> should.equal(2)
  stat.name |> should.equal("attack")
  stat.game_index |> should.equal(2)
  stat.is_battle_only |> should.be_false

  let assert NamedResource(url, name) = stat.move_damage_class
  name |> should.equal("physical")
  url |> should.equal("https://pokeapi.co/api/v2/move-damage-class/2/")

  let increasing_move =
    stat.affecting_moves.increase |> list.first |> should.be_ok
  increasing_move.change |> should.equal(2)

  let assert NamedResource(url, name) = increasing_move.move
  name |> should.equal("swords-dance")
  url |> should.equal("https://pokeapi.co/api/v2/move/14/")

  let decreasing_move =
    stat.affecting_moves.decrease |> list.first |> should.be_ok
  decreasing_move.change |> should.equal(-1)

  let assert NamedResource(url, name) = decreasing_move.move
  name |> should.equal("growl")
  url |> should.equal("https://pokeapi.co/api/v2/move/45/")

  let assert NamedResource(url, name) =
    stat.affecting_natures.increase |> list.first |> should.be_ok
  name |> should.equal("lonely")
  url |> should.equal("https://pokeapi.co/api/v2/nature/6/")

  let assert NamedResource(url, name) =
    stat.affecting_natures.decrease |> list.first |> should.be_ok
  name |> should.equal("bold")
  url |> should.equal("https://pokeapi.co/api/v2/nature/2/")

  let name = stat.names |> should_have_english_name
  name.name |> should.equal("Attack")
}
