import decode
import tallgrass/client.{type Client}
import tallgrass/resource.{type Resource, resource}

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

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of pokemon gender resources.
///
/// # Example
///
/// ```gleam
/// let result = gender.new() |> gender.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.client_fetch_resources(client, path)
}

/// Fetches a pokemon gender given a pokemon gender resource.
///
/// # Example
///
/// ```gleam
/// let client = gender.new()
/// use res <- result.try(client |> gender.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> gender.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.client_fetch_resource(client, resource, gender())
}

/// Fetches a pokemon gender given the pokemon gender ID.
///
/// # Example
///
/// ```gleam
/// let result = gender.new() |> gender.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.client_fetch_by_id(client, path, id, gender())
}

/// Fetches a pokemon gender given the pokemon gender name.
///
/// # Example
///
/// ```gleam
/// let result = gender.new() |> gender.fetch_by_name("genderless")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.client_fetch_by_name(client, path, name, gender())
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
