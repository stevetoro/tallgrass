import gleam/list
import gleam/option.{None}
import gleeunit/should
import tallgrass/berry.{type Berry}
import tallgrass/resource.{NamedResource}

pub fn fetch_test() {
  let response = berry.fetch(options: None) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  berry.fetch_resource(resource) |> should.be_ok |> should_be_cheri
}

pub fn fetch_by_id_test() {
  berry.fetch_by_id(1) |> should.be_ok |> should_be_cheri
}

pub fn fetch_by_name_test() {
  berry.fetch_by_name("cheri") |> should.be_ok |> should_be_cheri
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

  let assert NamedResource(url, name) = berry.firmness
  name |> should.equal("soft")
  url |> should.equal("https://pokeapi.co/api/v2/berry-firmness/2/")

  let flavor = berry.flavors |> list.first |> should.be_ok
  flavor.potency |> should.equal(10)

  let assert NamedResource(url, name) = flavor.flavor
  name |> should.equal("spicy")
  url |> should.equal("https://pokeapi.co/api/v2/berry-flavor/1/")

  let assert NamedResource(url, name) = berry.item
  name |> should.equal("cheri-berry")
  url |> should.equal("https://pokeapi.co/api/v2/item/126/")

  let assert NamedResource(url, name) = berry.natural_gift_type
  name |> should.equal("fire")
  url |> should.equal("https://pokeapi.co/api/v2/type/10/")
}
