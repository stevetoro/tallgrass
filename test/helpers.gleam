import gleam/list
import gleeunit/should
import tallgrass/common/resource.{NamedResource}
import tallgrass/common/name.{type Name}

pub fn should_have_english_name(names: List(Name)) {
  names
  |> list.filter(fn(name) {
    let assert NamedResource(url, name) = name.language
    name == "en" && url == "https://pokeapi.co/api/v2/language/9/"
  })
  |> list.first
  |> should.be_ok
}
