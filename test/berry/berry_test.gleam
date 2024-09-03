import gleam/list
import gleeunit/should
import tallgrass/client/berry as client
import tallgrass/internal/berry/berry/berry.{type Berry}

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_cheri
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("cheri") |> should.be_ok |> should_be_cheri
}

fn should_be_cheri(berry: Berry) {
  berry.id |> should.equal(1)
  berry.name |> should.equal("cheri")
  berry.growth_time |> should.equal(3)
  berry.max_harvest |> should.equal(5)
  berry.natural_gift_power |> should.equal(60)
  berry.size |> should.equal(20)
  berry.smoothness |> should.equal(25)
  berry.soil_dryness |> should.equal(15)

  berry.firmness.name |> should.equal("soft")
  berry.firmness.url
  |> should.equal("https://pokeapi.co/api/v2/berry-firmness/2/")

  let flavor = berry.flavors |> list.first |> should.be_ok
  flavor.potency |> should.equal(10)
  flavor.flavor.name |> should.equal("spicy")
  flavor.flavor.url |> should.equal("https://pokeapi.co/api/v2/berry-flavor/1/")

  berry.item.name |> should.equal("cheri-berry")
  berry.item.url
  |> should.equal("https://pokeapi.co/api/v2/item/126/")

  berry.natural_gift_type.name |> should.equal("fire")
  berry.natural_gift_type.url
  |> should.equal("https://pokeapi.co/api/v2/type/10/")
}
