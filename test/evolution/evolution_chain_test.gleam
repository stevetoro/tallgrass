import gleam/list
import gleam/option.{Some}
import gleeunit/should
import tallgrass/evolution/chain.{type EvolutionChain}
import tallgrass/resource.{NamedResource, PaginationOptions}

// TODO: Add test cases covering more fields.

pub fn fetch_test() {
  let options = PaginationOptions(limit: 1, offset: 199)
  let response = chain.fetch(options: Some(options)) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  chain.fetch_resource(resource) |> should.be_ok |> should_be_rayquaza
}

pub fn fetch_by_id_test() {
  chain.fetch_by_id(200) |> should.be_ok |> should_be_rayquaza
}

pub fn should_be_rayquaza(evolution_chain: EvolutionChain) {
  evolution_chain.id |> should.equal(200)
  evolution_chain.baby_trigger_item |> should.be_none

  evolution_chain.chain.evolution_details |> list.is_empty |> should.be_true
  // TODO: Figure out how to decode a recursive type.
  // evolution_chain.chain.evolves_to |> list.is_empty |> should.be_true
  evolution_chain.chain.is_baby |> should.be_false

  let assert NamedResource(url, name) = evolution_chain.chain.species
  name |> should.equal("rayquaza")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon-species/384/")
}
