import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/common/resource.{NamedResource}
import tallgrass/evolution/trigger.{type EvolutionTrigger}

pub fn fetch_test() {
  let resource =
    trigger.new()
    |> trigger.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  trigger.new()
  |> trigger.fetch_resource(resource)
  |> should.be_ok
  |> should_be_level_up
}

pub fn fetch_by_id_test() {
  trigger.new()
  |> trigger.fetch_by_id(1)
  |> should.be_ok
  |> should_be_level_up
}

pub fn fetch_by_name_test() {
  trigger.new()
  |> trigger.fetch_by_name("level-up")
  |> should.be_ok
  |> should_be_level_up
}

fn should_be_level_up(evolution_trigger: EvolutionTrigger) {
  evolution_trigger.id |> should.equal(1)
  evolution_trigger.name |> should.equal("level-up")

  let name = evolution_trigger.names |> should_have_english_name
  name.name |> should.equal("Level up")

  let assert NamedResource(url, name) =
    evolution_trigger.pokemon_species |> list.first |> should.be_ok
  name |> should.equal("ivysaur")
  url |> should.equal("https://pokeapi.co/api/v2/pokemon-species/2/")
}
