import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/cache.{NoCache}
import tallgrass/pokemon/species.{type PokemonSpecies}
import tallgrass/resource.{NamedResource, Offset}

pub fn fetch_test() {
  let response =
    species.fetch(options: Offset(412), cache: NoCache) |> should.be_ok
  let resource = response.results |> list.first |> should.be_ok
  species.fetch_resource(resource, NoCache)
  |> should.be_ok
  |> should_be_wormadam
}

pub fn fetch_by_id_test() {
  species.fetch_by_id(413, NoCache) |> should.be_ok |> should_be_wormadam
}

pub fn fetch_by_name_test() {
  species.fetch_by_name("wormadam", NoCache)
  |> should.be_ok
  |> should_be_wormadam
}

fn should_be_wormadam(species: PokemonSpecies) {
  species.id |> should.equal(413)
  species.name |> should.equal("wormadam")
  species.order |> should.equal(441)
  species.gender_rate |> should.equal(8)
  species.capture_rate |> should.equal(45)
  species.base_happiness |> should.equal(70)
  species.is_baby |> should.be_false
  species.is_legendary |> should.be_false
  species.is_mythical |> should.be_false
  species.hatch_counter |> should.equal(15)
  species.has_gender_differences |> should.be_false
  species.forms_switchable |> should.be_false

  let assert NamedResource(url, name) = species.growth_rate
  name |> should.equal("medium")
  url |> should.equal("https://pokeapi.co/api/v2/growth-rate/2/")

  let assert NamedResource(url, name) =
    species.egg_groups |> list.first |> should.be_ok
  name |> should.equal("bug")
  url |> should.equal("https://pokeapi.co/api/v2/egg-group/3/")

  let assert NamedResource(url, name) = species.color
  name |> should.equal("green")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon-color/5/")

  let assert NamedResource(url, name) = species.shape
  name |> should.equal("blob")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon-shape/5/")

  let assert NamedResource(url, name) = species.evolves_from_species
  name |> should.equal("burmy")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon-species/412/")

  let assert NamedResource(url, name) = species.generation
  name |> should.equal("generation-iv")
  url |> should.equal("https://pokeapi.co/api/v2/generation/4/")

  let name = species.names |> should_have_english_name
  name.name |> should.equal("Wormadam")
}
