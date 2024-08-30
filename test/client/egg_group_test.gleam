import api/egg_group.{type EggGroup}
import client/egg_group as client
import gleam/list
import gleeunit/should

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_monster
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("monster") |> should.be_ok |> should_be_monster
}

fn should_be_monster(egg_group: EggGroup) {
  egg_group.id |> should.equal(1)
  egg_group.name |> should.equal("monster")

  let name = egg_group.names |> list.first |> should.be_ok
  name.name |> should.equal("かいじゅう")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")
}
