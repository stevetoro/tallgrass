import client/species as client
import gleam/list
import gleeunit/should
import internal/pokemon/species/species.{type Species}

pub fn fetch_by_id_test() {
  client.fetch_by_id(413) |> should.be_ok |> should_be_wormadam
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("wormadam") |> should.be_ok |> should_be_wormadam
}

fn should_be_wormadam(species: Species) {
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

  species.growth_rate.name |> should.equal("medium")
  species.growth_rate.url
  |> should.equal("https://pokeapi.co/api/v2/growth-rate/2/")

  let egg_group = species.egg_groups |> list.first |> should.be_ok
  egg_group.name |> should.equal("bug")
  egg_group.url |> should.equal("https://pokeapi.co/api/v2/egg-group/3/")

  species.color.name |> should.equal("green")
  species.color.url
  |> should.equal("https://pokeapi.co/api/v2/pokemon-color/5/")

  species.shape.name |> should.equal("blob")
  species.shape.url
  |> should.equal("https://pokeapi.co/api/v2/pokemon-shape/5/")

  species.evolves_from_species.name |> should.equal("burmy")
  species.evolves_from_species.url
  |> should.equal("https://pokeapi.co/api/v2/pokemon-species/412/")

  species.generation.name |> should.equal("generation-iv")
  species.generation.url
  |> should.equal("https://pokeapi.co/api/v2/generation/4/")

  let name = species.names |> list.first |> should.be_ok
  name.name |> should.equal("ミノマダム")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")
}
