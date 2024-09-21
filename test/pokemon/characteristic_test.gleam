import gleam/list
import gleeunit/should
import tallgrass/pokemon/characteristic
import tallgrass/resource.{NamedResource}

pub fn fetch_by_id_test() {
  let characteristic = characteristic.fetch_by_id(1) |> should.be_ok

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
