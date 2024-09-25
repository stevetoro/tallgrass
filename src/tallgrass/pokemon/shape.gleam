import decode
import tallgrass/client.{type Client}
import tallgrass/common/resource.{type Resource, resource}
import tallgrass/common/name.{type Name, Name, name}

pub type PokemonShape {
  PokemonShape(
    id: Int,
    name: String,
    names: List(Name),
    awesome_names: List(Name),
    pokemon_species: List(Resource),
  )
}

const path = "pokemon-shape"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of pokemon shape resources.
///
/// # Example
///
/// ```gleam
/// let result = shape.new() |> shape.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches a pokemon shape given a pokemon shape resource.
///
/// # Example
///
/// ```gleam
/// let client = shape.new()
/// use res <- result.try(client |> shape.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> shape.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, pokemon_shape())
}

/// Fetches a pokemon shape given the pokemon shape ID.
///
/// # Example
///
/// ```gleam
/// let result = shape.new() |> shape.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, pokemon_shape())
}

/// Fetches a pokemon shape given the pokemon shape name.
///
/// # Example
///
/// ```gleam
/// let result = shape.new() |> shape.fetch_by_name("ball")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  client.fetch_by_name(client, path, name, pokemon_shape())
}

fn pokemon_shape() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use awesome_names <- decode.parameter
    use pokemon_species <- decode.parameter
    PokemonShape(id, name, names, awesome_names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("awesome_names", decode.list(of: awesome_name()))
  |> decode.field("pokemon_species", decode.list(of: resource()))
}

fn awesome_name() {
  decode.into({
    use name <- decode.parameter
    use language <- decode.parameter
    Name(name, language)
  })
  |> decode.field("awesome_name", decode.string)
  |> decode.field("language", resource())
}
