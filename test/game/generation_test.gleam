import gleam/list
import gleeunit/should
import tallgrass/client/generation as client
import tallgrass/internal/game/generation/generation.{type Generation}

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_generation_i
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("generation-i") |> should.be_ok |> should_be_generation_i
}

fn should_be_generation_i(generation: Generation) {
  generation.id |> should.equal(1)
  generation.name |> should.equal("generation-i")

  generation.abilities |> list.is_empty |> should.be_true

  generation.main_region.name |> should.equal("kanto")
  generation.main_region.url
  |> should.equal("https://pokeapi.co/api/v2/region/1/")

  let move = generation.moves |> list.first |> should.be_ok
  move.name |> should.equal("pound")
  move.url |> should.equal("https://pokeapi.co/api/v2/move/1/")

  let name = generation.names |> list.first |> should.be_ok
  name.name |> should.equal("だいいちせだい")
  name.language.name |> should.equal("ja-Hrkt")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/1/")

  let pokemon_species = generation.pokemon_species |> list.first |> should.be_ok
  pokemon_species.name |> should.equal("bulbasaur")
  pokemon_species.url
  |> should.equal("https://pokeapi.co/api/v2/pokemon-species/1/")

  let pokemon_type = generation.types |> list.first |> should.be_ok
  pokemon_type.name |> should.equal("normal")
  pokemon_type.url |> should.equal("https://pokeapi.co/api/v2/type/1/")

  let version_group = generation.version_groups |> list.first |> should.be_ok
  version_group.name |> should.equal("red-blue")
  version_group.url
  |> should.equal("https://pokeapi.co/api/v2/version-group/1/")
}
