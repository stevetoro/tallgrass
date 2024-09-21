import gleam/list
import gleeunit/should
import tallgrass/pokemon/growth_rate.{type GrowthRate}
import tallgrass/resource.{Default, NamedResource}

pub fn fetch_test() {
  let response = growth_rate.fetch(options: Default) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  growth_rate.fetch_resource(resource) |> should.be_ok |> should_be_slow
}

pub fn fetch_by_id_test() {
  growth_rate.fetch_by_id(1) |> should.be_ok |> should_be_slow
}

pub fn fetch_by_name_test() {
  growth_rate.fetch_by_name("slow") |> should.be_ok |> should_be_slow
}

fn should_be_slow(growth_rate: GrowthRate) {
  growth_rate.id |> should.equal(1)
  growth_rate.name |> should.equal("slow")
  growth_rate.formula |> should.equal("\\frac{5x^3}{4}")

  let description = growth_rate.descriptions |> list.first |> should.be_ok
  description.text |> should.equal("lente")

  let assert NamedResource(url, name) = description.language
  name |> should.equal("fr")
  url |> should.equal("https://pokeapi.co/api/v2/language/5/")

  let level = growth_rate.levels |> list.first |> should.be_ok
  level.level |> should.equal(1)
  level.experience |> should.equal(0)

  let assert NamedResource(url, name) =
    growth_rate.pokemon_species |> list.first |> should.be_ok
  name |> should.equal("growlithe")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon-species/58/")
}
