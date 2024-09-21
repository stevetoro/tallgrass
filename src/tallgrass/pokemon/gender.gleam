import decode
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type Gender {
  Gender(
    id: Int,
    name: String,
    pokemon_species_details: List(PokemonSpeciesGender),
    required_for_evolution: List(Resource),
  )
}

pub type PokemonSpeciesGender {
  PokemonSpeciesGender(rate: Int, pokemon_species: Resource)
}

const path = "gender"

/// Fetches a list of pokemon gender resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = gender.fetch(options: Default)
/// let result = gender.fetch(options: Some(PaginationOptions(limit: 100, offset: 0)))
/// ```
pub fn fetch(options options: PaginationOptions) {
  resource.fetch_resources(path, options)
}

/// Fetches a pokemon gender given a pokemon gender resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(gender.fetch(options: Default))
/// let assert Ok(first) = res.results |> list.first
/// gender.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: gender())
}

/// Fetches a pokemon gender given the pokemon gender ID.
///
/// # Example
///
/// ```gleam
/// let result = gender.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, gender())
}

/// Fetches a pokemon gender given the pokemon gender name.
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
  |> decode.field("required_for_evolution", decode.list(of: resource()))
}

fn pokemon_species_gender() {
  decode.into({
    use rate <- decode.parameter
    use species <- decode.parameter
    PokemonSpeciesGender(rate, species)
  })
  |> decode.field("rate", decode.int)
  |> decode.field("pokemon_species", resource())
}
