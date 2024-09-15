import gleam/list
import gleeunit/should
import tallgrass/pokemon/color.{type Color}

pub fn fetch_by_id_test() {
  color.fetch_by_id(1) |> should.be_ok |> should_be_black
}

pub fn fetch_by_name_test() {
  color.fetch_by_name("black") |> should.be_ok |> should_be_black
}

fn should_be_black(color: Color) {
  color.id |> should.equal(1)
  color.name |> should.equal("black")

  let name = color.names |> list.first |> should.be_ok
  name.name |> should.equal("くろいろ")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")
}
