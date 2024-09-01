import gleam/list
import gleeunit/should
import tallgrass/client/nature as client
import tallgrass/internal/pokemon/nature/nature.{type Nature}

pub fn fetch_by_id_test() {
  client.fetch_by_id(2) |> should.be_ok |> should_be_bold
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("hardy") |> should.be_ok |> should_be_hardy
}

fn should_be_bold(nature: Nature) {
  nature.id |> should.equal(2)
  nature.name |> should.equal("bold")

  let decreased_stat = nature.decreased_stat |> should.be_some
  decreased_stat.name |> should.equal("attack")
  decreased_stat.url |> should.equal("https://pokeapi.co/api/v2/stat/2/")

  let increased_stat = nature.increased_stat |> should.be_some
  increased_stat.name |> should.equal("defense")
  increased_stat.url |> should.equal("https://pokeapi.co/api/v2/stat/3/")

  let likes_flavor = nature.likes_flavor |> should.be_some
  likes_flavor.name |> should.equal("sour")
  likes_flavor.url |> should.equal("https://pokeapi.co/api/v2/berry-flavor/5/")

  let hates_flavor = nature.hates_flavor |> should.be_some
  hates_flavor.name |> should.equal("spicy")
  hates_flavor.url |> should.equal("https://pokeapi.co/api/v2/berry-flavor/1/")

  let stat_change = nature.pokeathlon_stat_changes |> list.first |> should.be_ok
  stat_change.max_change |> should.equal(-2)
  stat_change.pokeathlon_stat.name |> should.equal("speed")
  stat_change.pokeathlon_stat.url
  |> should.equal("https://pokeapi.co/api/v2/pokeathlon-stat/1/")

  let style_preference =
    nature.move_battle_style_preferences |> list.first |> should.be_ok
  style_preference.low_hp_preference |> should.equal(32)
  style_preference.high_hp_preference |> should.equal(30)
  style_preference.move_battle_style.name |> should.equal("attack")
  style_preference.move_battle_style.url
  |> should.equal("https://pokeapi.co/api/v2/move-battle-style/1/")

  let name = nature.names |> list.first |> should.be_ok
  name.name |> should.equal("ずぶとい")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")
}

fn should_be_hardy(nature: Nature) {
  nature.id |> should.equal(1)
  nature.name |> should.equal("hardy")

  nature.decreased_stat |> should.be_none
  nature.increased_stat |> should.be_none
  nature.likes_flavor |> should.be_none
  nature.hates_flavor |> should.be_none

  let stat_change = nature.pokeathlon_stat_changes |> list.first |> should.be_ok
  stat_change.max_change |> should.equal(-1)
  stat_change.pokeathlon_stat.name |> should.equal("speed")
  stat_change.pokeathlon_stat.url
  |> should.equal("https://pokeapi.co/api/v2/pokeathlon-stat/1/")

  let style_preference =
    nature.move_battle_style_preferences |> list.first |> should.be_ok
  style_preference.low_hp_preference |> should.equal(61)
  style_preference.high_hp_preference |> should.equal(61)
  style_preference.move_battle_style.name |> should.equal("attack")
  style_preference.move_battle_style.url
  |> should.equal("https://pokeapi.co/api/v2/move-battle-style/1/")

  let name = nature.names |> list.first |> should.be_ok
  name.name |> should.equal("がんばりや")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")
}
