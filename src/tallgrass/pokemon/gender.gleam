import decode
import tallgrass/resource.{type NamedResource, named_resource}

pub type Gender {
  Gender(
    id: Int,
    name: String,
    pokemon_species_details: List(PokemonSpeciesGender),
    required_for_evolution: List(NamedResource),
  )
}

pub type PokemonSpeciesGender {
  PokemonSpeciesGender(rate: Int, pokemon_species: NamedResource)
}

const path = "gender"

/// Fetches a pokemon gender by the gender ID.
///
/// # Example
///
/// ```gleam
/// let result = gender.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, gender())
}

/// Fetches a pokemon gender by the gender name.
///
/// # Example
///
/// ```gleam
/// let result = gender.fetch_by_name("genderless")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, gender())
}

fn gender() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use pokemon_species <- decode.parameter
    use required_for_evolution <- decode.parameter
    Gender(id, name, pokemon_species, required_for_evolution)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field(
    "pokemon_species_details",
    decode.list(of: pokemon_species_gender()),
  )
  |> decode.field("required_for_evolution", decode.list(of: named_resource()))
}

fn pokemon_species_gender() {
  decode.into({
    use rate <- decode.parameter
    use species <- decode.parameter
    PokemonSpeciesGender(rate, species)
  })
  |> decode.field("rate", decode.int)
  |> decode.field("pokemon_species", named_resource())
}
