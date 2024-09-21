import gleam/list
import gleam/option.{Some}
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/move/ailment.{type MoveAilment}
import tallgrass/resource.{NamedResource, PaginationOptions}

pub fn fetch_test() {
  let options = PaginationOptions(limit: 1, offset: 2)
  let response = ailment.fetch(options: Some(options)) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  ailment.fetch_resource(resource) |> should.be_ok |> should_be_paralysis
}

pub fn fetch_by_id_test() {
  ailment.fetch_by_id(1) |> should.be_ok |> should_be_paralysis
}

pub fn fetch_by_name_test() {
  ailment.fetch_by_name("paralysis") |> should.be_ok |> should_be_paralysis
}

fn should_be_paralysis(ailment: MoveAilment) {
  ailment.id |> should.equal(1)
  ailment.name |> should.equal("paralysis")

  let assert NamedResource(url, name) =
    ailment.moves |> list.first |> should.be_ok
  name |> should.equal("thunder-punch")
  url |> should.equal("https://pokeapi.co/api/v2/move/9/")

  let name = ailment.names |> should_have_english_name
  name.name |> should.equal("Paralysis")
}
