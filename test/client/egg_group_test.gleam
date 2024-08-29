import api/egg_group.{type EggGroup}
import client/egg_group as client
import gleam/list
import gleeunit/should

pub fn fetch_by_id_test() {
  let assert Ok(egg_group) = client.fetch_by_id(1)
  egg_group |> should_be_monster
}

pub fn fetch_by_name_test() {
  let assert Ok(egg_group) = client.fetch_by_name("monster")
  egg_group |> should_be_monster
}

fn should_be_monster(egg_group: EggGroup) {
  egg_group.id |> should.equal(1)
  egg_group.name |> should.equal("monster")

  let assert Ok(name) = egg_group.names |> list.first

  name.name |> should.equal("かいじゅう")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")
}
