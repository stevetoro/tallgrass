import decode
import pokegleam/common/affordance.{type Affordance, Affordance, affordance}

pub type Gender {
  Gender(
    id: Int,
    name: String,
    pokemon_species_details: List(PokemonSpecies),
    required_for_evolution: List(Affordance),
  )
}

pub type PokemonSpecies {
  PokemonSpecies(name: String, rate: Int, affordance: Affordance)
}

pub fn gender() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use pokemon_species <- decode.parameter
    use required_for_evolution <- decode.parameter
    Gender(id, name, pokemon_species, required_for_evolution)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("pokemon_species_details", decode.list(of: pokemon_species()))
  |> decode.field("required_for_evolution", decode.list(of: affordance()))
}

fn pokemon_species() {
  decode.into({
    use name <- decode.parameter
    use rate <- decode.parameter
    use affordance <- decode.parameter
    PokemonSpecies(name, rate, affordance)
  })
  |> decode.subfield(["pokemon_species", "name"], decode.string)
  |> decode.field("rate", decode.int)
  |> decode.field("pokemon_species", affordance())
}
