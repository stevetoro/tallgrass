import gleam/list
import gleeunit/should
import tallgrass/client.{with_pagination}
import tallgrass/page.{Limit, Paginate}
import tallgrass/request.{NoNextPage, NoPreviousPage}
import tallgrass/resource.{NamedResource, next, previous}

pub fn pagination_test() {
  let first_page =
    client.new()
    |> with_pagination(Paginate(3, 2))
    |> resource.fetch_resources("pokemon")
    |> should.be_ok

  let assert NamedResource(_url, name) =
    first_page.results
    |> list.first
    |> should.be_ok

  name |> should.equal("venusaur")

  let second_page =
    client.new()
    |> resource.next(first_page)
    |> should.be_ok

  let assert NamedResource(_url, name) =
    second_page.results
    |> list.first
    |> should.be_ok

  name |> should.equal("charizard")

  let first_page =
    client.new()
    |> resource.previous(second_page)
    |> should.be_ok

  let assert NamedResource(_url, name) =
    first_page.results
    |> list.first
    |> should.be_ok

  name |> should.equal("venusaur")
}

pub fn no_previous_page_test() {
  let first_page =
    client.new()
    |> with_pagination(Limit(5))
    |> resource.fetch_resources("pokemon")
    |> should.be_ok

  first_page.results |> list.length |> should.equal(5)
  first_page.previous |> should.be_none

  client.new()
  |> previous(first_page)
  |> should.be_error
  |> should.equal(NoPreviousPage)
}

pub fn no_next_page_test() {
  let final_page =
    client.new()
    |> resource.fetch_resources("pokemon")
    |> should.be_ok
    |> fn(response) {
      client.new()
      |> with_pagination(Paginate(10, response.count - 10))
      |> resource.fetch_resources("pokemon")
      |> should.be_ok
    }

  final_page.results |> list.length |> should.equal(10)
  final_page.next |> should.be_none

  client.new()
  |> next(final_page)
  |> should.be_error
  |> should.equal(NoNextPage)
}
