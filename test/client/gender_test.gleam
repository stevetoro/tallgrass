import api/gender.{type Gender}
import client/gender as client
import gleam/list
import gleeunit/should

pub fn fetch_by_id_test() {
  let assert Ok(gender) = client.fetch_by_id(1)
  gender |> should_be_female
}

pub fn fetch_by_name_test() {
  let assert Ok(gender) = client.fetch_by_name("female")
  gender |> should_be_female
}

fn should_be_female(gender: Gender) {
  gender.id |> should.equal(1)
  gender.name |> should.equal("female")

  let assert Ok(species) = gender.pokemon_species_details |> list.first

  species.name |> should.equal("bulbasaur")
  species.rate |> should.equal(1)
  species.affordance.name |> should.equal("bulbasaur")
  species.affordance.url
  |> should.equal("https://pokeapi.co/api/v2/pokemon-species/1/")

  let assert Ok(required) = gender.required_for_evolution |> list.first

  required.name |> should.equal("wormadam")
  required.url |> should.equal("https://pokeapi.co/api/v2/pokemon-species/413/")
}
