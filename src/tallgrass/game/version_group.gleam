import decode
import tallgrass/client.{type Client}
import tallgrass/resource.{type Resource, resource}

pub type VersionGroup {
  VersionGroup(
    id: Int,
    name: String,
    order: Int,
    generation: Resource,
    move_learn_methods: List(Resource),
    pokedexes: List(Resource),
    regions: List(Resource),
    versions: List(Resource),
  )
}

const path = "version-group"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of version group resources.
///
/// # Example
///
/// ```gleam
/// let result = version_group.new() |> version_group.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.client_fetch_resources(client, path)
}

/// Fetches a version group given a version group resource.
///
/// # Example
///
/// ```gleam
/// let client = version_group.new()
/// use res <- result.try(client |> version_group.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> version_group.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.client_fetch_resource(client, resource, version_group())
}

/// Fetches a version group given the version group ID.
///
/// # Example
///
/// ```gleam
/// let result = version_group.new() |> version_group.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.client_fetch_by_id(client, path, id, version_group())
}

/// Fetches a version group given the version group name.
///
/// # Example
///
/// ```gleam
/// let result = version_group.new() |> version_group.fetch_by_name("red-blue")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.client_fetch_by_name(client, path, name, version_group())
}

fn version_group() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use order <- decode.parameter
    use generation <- decode.parameter
    use move_learn_methods <- decode.parameter
    use pokedexes <- decode.parameter
    use regions <- decode.parameter
    use versions <- decode.parameter
    VersionGroup(
      id,
      name,
      order,
      generation,
      move_learn_methods,
      pokedexes,
      regions,
      versions,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("order", decode.int)
  |> decode.field("generation", resource())
  |> decode.field("move_learn_methods", decode.list(of: resource()))
  |> decode.field("pokedexes", decode.list(of: resource()))
  |> decode.field("regions", decode.list(of: resource()))
  |> decode.field("versions", decode.list(of: resource()))
}
