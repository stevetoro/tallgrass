import api/pokemon as api
import client/pokemon as client
import gleam/list
import gleeunit/should

pub fn get_pokemon_by_id_test() {
  let assert Ok(pokemon) = client.get_by_id(1)
  pokemon
  |> should_be_bulbasaur
}

pub fn get_pokemon_by_name_test() {
  let assert Ok(pokemon) = client.get_by_name("bulbasaur")
  pokemon
  |> should_be_bulbasaur
}

fn should_be_bulbasaur(pokemon: api.Pokemon) {
  pokemon.id
  |> should.equal(1)

  pokemon.name
  |> should.equal("bulbasaur")

  let assert Ok(ability) = pokemon.abilities |> list.first

  ability.ability.name
  |> should.equal("overgrow")

  ability.ability.url
  |> should.equal("https://pokeapi.co/api/v2/ability/65/")

  ability.is_hidden
  |> should.be_false

  ability.slot
  |> should.equal(1)

  pokemon.base_experience
  |> should.equal(64)

  pokemon.cries.latest
  |> should.equal(
    "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/1.ogg",
  )

  pokemon.cries.legacy
  |> should.equal(
    "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/legacy/1.ogg",
  )

  let assert Ok(form) = pokemon.forms |> list.first

  form.name
  |> should.equal("bulbasaur")

  form.url
  |> should.equal("https://pokeapi.co/api/v2/pokemon-form/1/")

  let assert Ok(index) = pokemon.game_indices |> list.first

  index.game_index
  |> should.equal(153)

  index.version.name
  |> should.equal("red")

  index.version.url
  |> should.equal("https://pokeapi.co/api/v2/version/1/")

  pokemon.height
  |> should.equal(7)

  pokemon.is_default
  |> should.be_true

  pokemon.location_area_encounters
  |> should.equal("https://pokeapi.co/api/v2/pokemon/1/encounters")

  let assert Ok(move) = pokemon.moves |> list.first

  move.move.name
  |> should.equal("razor-wind")

  move.move.url
  |> should.equal("https://pokeapi.co/api/v2/move/13/")

  let assert Ok(details) = move.version_group_details |> list.first

  details.level_learned_at
  |> should.equal(0)

  details.move_learn_method.name
  |> should.equal("egg")

  details.move_learn_method.url
  |> should.equal("https://pokeapi.co/api/v2/move-learn-method/2/")

  details.version_group.name
  |> should.equal("gold-silver")

  details.version_group.url
  |> should.equal("https://pokeapi.co/api/v2/version-group/3/")

  pokemon.order
  |> should.equal(1)

  pokemon.species.name
  |> should.equal("bulbasaur")

  pokemon.species.url
  |> should.equal("https://pokeapi.co/api/v2/pokemon-species/1/")

  let assert Ok(stat) = pokemon.stats |> list.first

  stat.base_stat
  |> should.equal(45)

  stat.effort
  |> should.equal(0)

  stat.stat.name
  |> should.equal("hp")

  stat.stat.url
  |> should.equal("https://pokeapi.co/api/v2/stat/1/")

  let assert Ok(typ) = pokemon.types |> list.first

  typ.slot
  |> should.equal(1)

  typ.type_a.name
  |> should.equal("grass")

  typ.type_a.url
  |> should.equal("https://pokeapi.co/api/v2/type/12/")

  pokemon.weight
  |> should.equal(69)
}
