import decode
import tallgrass/client.{type Client}
import tallgrass/common/name.{type Name, name}
import tallgrass/client/resource.{type Resource, resource}

pub type Habitat {
  Habitat(
    id: Int,
    name: String,
    names: List(Name),
    pokemon_species: List(Resource),
  )
}

const path = "pokemon-habitat"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of pokemon habitat resources.
///
/// # Example
///
/// ```gleam
/// let result = habitat.new() |> habitat.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches a pokemon habitat given a pokemon habitat resource.
///
/// # Example
///
/// ```gleam
/// let client = habitat.new()
/// use res <- result.try(client |> habitat.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> habitat.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, habitat())
}

/// Fetches a pokemon habitat given the pokemon habitat ID.
///
/// # Example
///
/// ```gleam
/// let result = habitat.new() |> habitat.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, habitat())
}

/// Fetches a pokemon habitat given the pokemon habitat name.
///
/// # Example
///
/// ```gleam
/// let result = habitat.new() |> habitat.fetch_by_name("cave")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, habitat())
}

fn habitat() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    Habitat(id, name, names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: resource()))
}
