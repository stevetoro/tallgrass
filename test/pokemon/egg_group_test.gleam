import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/pokemon/egg_group.{type EggGroup}

pub fn fetch_test() {
  let resource =
    egg_group.new()
    |> egg_group.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  egg_group.new()
  |> egg_group.fetch_resource(resource)
  |> should.be_ok
  |> should_be_monster
}

pub fn fetch_by_id_test() {
  egg_group.new()
  |> egg_group.fetch_by_id(1)
  |> should.be_ok
  |> should_be_monster
}

pub fn fetch_by_name_test() {
  egg_group.new()
  |> egg_group.fetch_by_name("monster")
  |> should.be_ok
  |> should_be_monster
}

fn should_be_monster(egg_group: EggGroup) {
  egg_group.id |> should.equal(1)
  egg_group.name |> should.equal("monster")
  let name = egg_group.names |> should_have_english_name
  name.name |> should.equal("Monster")
}
