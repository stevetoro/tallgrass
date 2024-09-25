import decode
import tallgrass/client.{type Client}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

pub type EggGroup {
  EggGroup(
    id: Int,
    name: String,
    names: List(Name),
    pokemon_species: List(Resource),
  )
}

const path = "egg-group"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of egg group resources.
///
/// # Example
///
/// ```gleam
/// let result = egg_group.new() |> egg_group.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches a egg group given a egg group resource.
///
/// # Example
///
/// ```gleam
/// let client = egg_group.new()
/// use res <- result.try(client |> egg_group.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> egg_group.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, egg_group())
}

/// Fetches a egg group given the egg group ID.
///
/// # Example
///
/// ```gleam
/// let result = egg_group.new() |> egg_group.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, egg_group())
}

/// Fetches a egg group given the egg group name.
///
/// # Example
///
/// ```gleam
/// let result = egg_group.new() |> egg_group.fetch_by_name("monster")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, egg_group())
}

fn egg_group() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    EggGroup(id, name, names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: resource()))
}
