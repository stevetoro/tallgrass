import gleam/list
import gleeunit/should
import tallgrass/request.{NoNextPage, NoPreviousPage}
import tallgrass/resource.{Default, NamedResource, Paginate, next, previous}

pub fn pagination_test() {
  let response =
    resource.fetch_resources("pokemon", Paginate(limit: 3, offset: 2))
    |> should.be_ok
  response.results |> list.length |> should.equal(3)

  let assert NamedResource(_url, name) =
    response.results |> list.first |> should.be_ok
  name |> should.equal("venusaur")

  let response = response |> next |> should.be_ok
  response.results |> list.length |> should.equal(3)
  let assert NamedResource(_url, name) =
    response.results |> list.first |> should.be_ok
  name |> should.equal("charizard")

  let response = response |> previous |> should.be_ok
  response.results |> list.length |> should.equal(3)
  let assert NamedResource(_url, name) =
    response.results |> list.first |> should.be_ok
  name |> should.equal("venusaur")
}

pub fn no_previous_page_test() {
  // fetch the first page of 5 resources
  let options = Paginate(limit: 5, offset: 0)
  let response = resource.fetch_resources("pokemon", options) |> should.be_ok

  response.results |> list.length |> should.equal(5)

  // no pagination options, this is the beginning of the first page
  response.previous |> should.be_none
  response
  |> previous
  |> should.be_error
  |> should.equal(NoPreviousPage)
}

pub fn no_next_page_test() {
  let response = resource.fetch_resources("pokemon", Default) |> should.be_ok

  // fetch the final page of 10 resources
  let options = Paginate(limit: 10, offset: response.count - 10)
  let response = resource.fetch_resources("pokemon", options) |> should.be_ok

  response.results |> list.length |> should.equal(10)

  // this is the final page
  response.next |> should.be_none
  response
  |> next
  |> should.be_error
  |> should.equal(NoNextPage)
}
