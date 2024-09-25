import decode
import tallgrass/client.{type Client}
import tallgrass/common/resource.{type Resource, resource}
import tallgrass/common/name.{type Name, name}

pub type PokemonColor {
  PokemonColor(
    id: Int,
    name: String,
    names: List(Name),
    pokemon_species: List(Resource),
  )
}

const path = "pokemon-color"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of pokemon color resources.
///
/// # Example
///
/// ```gleam
/// let result = color.new() |> color.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches a pokemon color given a pokemon color resource.
///
/// # Example
///
/// ```gleam
/// let client = color.new()
/// use res <- result.try(client |> color.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> color.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, pokemon_color())
}

/// Fetches a pokemon color given the pokemon color ID.
///
/// # Example
///
/// ```gleam
/// let result = color.new() |> color.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, pokemon_color())
}

/// Fetches a pokemon color given the pokemon color name.
///
/// # Example
///
/// ```gleam
/// let result = color.new() |> color.fetch_by_name("black")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  client.fetch_by_name(client, path, name, pokemon_color())
}

fn pokemon_color() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    PokemonColor(id, name, names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: resource()))
}
