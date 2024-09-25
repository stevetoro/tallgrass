import gleam/list
import gleeunit/should
import tallgrass/client.{with_pagination}
import tallgrass/client/pagination.{Offset}
import tallgrass/client/resource.{NamedResource}
import tallgrass/move/category.{type MoveCategory}

pub fn fetch_test() {
  let resource =
    category.new()
    |> with_pagination(Offset(1))
    |> category.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  category.new()
  |> category.fetch_resource(resource)
  |> should.be_ok
  |> should_be_ailment
}

pub fn fetch_by_id_test() {
  category.new()
  |> category.fetch_by_id(1)
  |> should.be_ok
  |> should_be_ailment
}

pub fn fetch_by_name_test() {
  category.new()
  |> category.fetch_by_name("ailment")
  |> should.be_ok
  |> should_be_ailment
}

fn should_be_ailment(category: MoveCategory) {
  category.id |> should.equal(1)
  category.name |> should.equal("ailment")

  let description = category.descriptions |> list.first |> should.be_ok
  description.text |> should.equal("No damage; inflicts status ailment")

  let assert NamedResource(url, name) = description.language
  name |> should.equal("en")
  url |> should.equal("https://pokeapi.co/api/v2/language/9/")

  let assert NamedResource(url, name) =
    category.moves |> list.first |> should.be_ok
  name |> should.equal("sing")
  url |> should.equal("https://pokeapi.co/api/v2/move/47/")
}
