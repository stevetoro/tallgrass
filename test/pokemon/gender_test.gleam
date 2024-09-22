import gleam/list
import gleeunit/should
import tallgrass/cache.{NoCache}
import tallgrass/pokemon/gender.{type Gender}
import tallgrass/resource.{DefaultPagination, NamedResource}

pub fn fetch_test() {
  let response = gender.fetch(DefaultPagination, NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  gender.fetch_resource(resource, NoCache) |> should.be_ok |> should_be_female
}

pub fn fetch_by_id_test() {
  gender.fetch_by_id(1, NoCache) |> should.be_ok |> should_be_female
}

pub fn fetch_by_name_test() {
  gender.fetch_by_name("female", NoCache) |> should.be_ok |> should_be_female
}

fn should_be_female(gender: Gender) {
  gender.id |> should.equal(1)
  gender.name |> should.equal("female")

  let species = gender.pokemon_species_details |> list.first |> should.be_ok
  species.rate |> should.equal(1)

  let assert NamedResource(url, name) = species.pokemon_species
  name |> should.equal("bulbasaur")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon-species/1/")

  let assert NamedResource(url, name) =
    gender.required_for_evolution |> list.first |> should.be_ok
  name |> should.equal("wormadam")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon-species/413/")
}
