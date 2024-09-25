import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/client.{with_pagination}
import tallgrass/page.{Offset}
import tallgrass/pokemon/nature.{type Nature}
import tallgrass/resource.{NamedResource}

pub fn fetch_test() {
  let resource =
    nature.new()
    |> with_pagination(Offset(1))
    |> nature.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  nature.new()
  |> nature.fetch_resource(resource)
  |> should.be_ok
  |> should_be_bold
}

pub fn fetch_by_id_test() {
  nature.new()
  |> nature.fetch_by_id(2)
  |> should.be_ok
  |> should_be_bold
}

pub fn fetch_by_name_test() {
  nature.new()
  |> nature.fetch_by_name("bold")
  |> should.be_ok
  |> should_be_bold
}

fn should_be_bold(nature: Nature) {
  nature.id |> should.equal(2)
  nature.name |> should.equal("bold")

  let assert NamedResource(url, name) = nature.decreased_stat |> should.be_some
  name |> should.equal("attack")
  url |> should.equal("https://pokeapi.co/api/v2/stat/2/")

  let assert NamedResource(url, name) = nature.increased_stat |> should.be_some
  name |> should.equal("defense")
  url |> should.equal("https://pokeapi.co/api/v2/stat/3/")

  let assert NamedResource(url, name) = nature.likes_flavor |> should.be_some
  name |> should.equal("sour")
  url |> should.equal("https://pokeapi.co/api/v2/berry-flavor/5/")

  let assert NamedResource(url, name) = nature.hates_flavor |> should.be_some
  name |> should.equal("spicy")
  url |> should.equal("https://pokeapi.co/api/v2/berry-flavor/1/")

  let stat_change = nature.pokeathlon_stat_changes |> list.first |> should.be_ok
  stat_change.max_change |> should.equal(-2)

  let assert NamedResource(url, name) = stat_change.pokeathlon_stat
  name |> should.equal("speed")
  url |> should.equal("https://pokeapi.co/api/v2/pokeathlon-stat/1/")

  let style_preference =
    nature.move_battle_style_preferences |> list.first |> should.be_ok
  style_preference.low_hp_preference |> should.equal(32)
  style_preference.high_hp_preference |> should.equal(30)

  let assert NamedResource(url, name) = style_preference.move_battle_style
  name |> should.equal("attack")
  url |> should.equal("https://pokeapi.co/api/v2/move-battle-style/1/")

  let name = nature.names |> should_have_english_name
  name.name |> should.equal("Bold")
}
