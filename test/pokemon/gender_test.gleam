import gleam/list
import gleeunit/should
import tallgrass/pokemon/gender.{type Gender}

pub fn fetch_by_id_test() {
  gender.fetch_by_id(1) |> should.be_ok |> should_be_female
}

pub fn fetch_by_name_test() {
  gender.fetch_by_name("female") |> should.be_ok |> should_be_female
}

fn should_be_female(gender: Gender) {
  gender.id |> should.equal(1)
  gender.name |> should.equal("female")

  let species = gender.pokemon_species_details |> list.first |> should.be_ok
  species.rate |> should.equal(1)
  species.pokemon_species.name |> should.equal("bulbasaur")
  species.pokemon_species.url
  |> should.equal("https://pokeapi.co/api/v2/pokemon-species/1/")

  let required = gender.required_for_evolution |> list.first |> should.be_ok
  required.name |> should.equal("wormadam")
  required.url |> should.equal("https://pokeapi.co/api/v2/pokemon-species/413/")
}
