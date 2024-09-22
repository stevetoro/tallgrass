import gleam/list
import gleeunit/should
import tallgrass/cache.{NoCache}
import tallgrass/pokemon/characteristic.{type Characteristic}
import tallgrass/resource.{Default, NamedResource}

pub fn fetch_test() {
  let response =
    characteristic.fetch(options: Default, cache: NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  characteristic.fetch_resource(resource, NoCache)
  |> should.be_ok
  |> should_be_characteristic
}

pub fn fetch_by_id_test() {
  characteristic.fetch_by_id(1, NoCache)
  |> should.be_ok
  |> should_be_characteristic
}

fn should_be_characteristic(characteristic: Characteristic) {
  characteristic.id |> should.equal(1)
  characteristic.gene_modulo |> should.equal(0)
  characteristic.possible_values |> should.equal([0, 5, 10, 15, 20, 25, 30])

  let assert NamedResource(url, name) = characteristic.highest_stat
  name |> should.equal("hp")
  url |> should.equal("https://pokeapi.co/api/v2/stat/1/")

  let description = characteristic.descriptions |> list.first |> should.be_ok
  description.text |> should.equal("たべるのが　だいすき")

  let assert NamedResource(url, name) = description.language
  name |> should.equal("ja-Hrkt")
  url |> should.equal("https://pokeapi.co/api/v2/language/1/")
}
