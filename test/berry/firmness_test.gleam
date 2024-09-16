import gleam/list
import gleeunit/should
import tallgrass/berry/firmness.{type BerryFirmness}

pub fn fetch_by_id_test() {
  firmness.fetch_by_id(1) |> should.be_ok |> should_be_very_soft
}

pub fn fetch_by_name_test() {
  firmness.fetch_by_name("very-soft") |> should.be_ok |> should_be_very_soft
}

fn should_be_very_soft(firmness: BerryFirmness) {
  firmness.id |> should.equal(1)
  firmness.name |> should.equal("very-soft")

  let berry = firmness.berries |> list.first |> should.be_ok
  berry.name |> should.equal("pecha")
  berry.url |> should.equal("https://pokeapi.co/api/v2/berry/3/")

  let name = firmness.names |> list.first |> should.be_ok
  name.name |> should.equal("とてもやわらかい")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")
}
