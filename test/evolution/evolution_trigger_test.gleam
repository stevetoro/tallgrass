import gleam/list
import gleeunit/should
import tallgrass/client/evolution_trigger as client
import tallgrass/internal/evolution/evolution_trigger/evolution_trigger.{
  type EvolutionTrigger,
}

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_level_up
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("level-up") |> should.be_ok |> should_be_level_up
}

fn should_be_level_up(evolution_trigger: EvolutionTrigger) {
  evolution_trigger.id |> should.equal(1)
  evolution_trigger.name |> should.equal("level-up")

  let name = evolution_trigger.names |> list.first |> should.be_ok
  name.name |> should.equal("Montée de niveau")
  name.language.name |> should.equal("fr")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/5/")

  let species = evolution_trigger.pokemon_species |> list.first |> should.be_ok
  species.name |> should.equal("ivysaur")
  species.url |> should.equal("https://pokeapi.co/api/v2/pokemon-species/2/")
}
