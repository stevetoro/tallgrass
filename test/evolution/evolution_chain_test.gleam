import gleam/list
import gleeunit/should
import tallgrass/evolution/chain
import tallgrass/resource.{NamedResource}

// TODO: Add test cases covering more fields.

pub fn fetch_by_id_test() {
  let evolution_chain = chain.fetch_by_id(200) |> should.be_ok

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
