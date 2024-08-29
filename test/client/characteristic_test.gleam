import client/characteristic
import gleam/list
import gleeunit/should

pub fn fetch_by_id_test() {
  let assert Ok(characteristic) = characteristic.fetch_by_id(1)

  characteristic.id |> should.equal(1)
  characteristic.gene_modulo |> should.equal(0)
  characteristic.possible_values |> should.equal([0, 5, 10, 15, 20, 25, 30])

  characteristic.highest_stat.name |> should.equal("hp")
  characteristic.highest_stat.url
  |> should.equal("https://pokeapi.co/api/v2/stat/1/")

  let assert Ok(description) = characteristic.descriptions |> list.first

  description.text |> should.equal("たべるのが　だいすき")
  description.language.name |> should.equal("ja-Hrkt")
  description.language.url
  |> should.equal("https://pokeapi.co/api/v2/language/1/")
}