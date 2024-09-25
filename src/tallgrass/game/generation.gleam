import decode
import tallgrass/client.{type Client}
import tallgrass/common/resource.{type Resource, resource}
import tallgrass/common/name.{type Name, name}

pub type Generation {
  Generation(
    id: Int,
    name: String,
    abilities: List(Resource),
    main_region: Resource,
    moves: List(Resource),
    names: List(Name),
    pokemon_species: List(Resource),
    types: List(Resource),
    version_groups: List(Resource),
  )
}

const path = "generation"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of generation resources.
///
/// # Example
///
/// ```gleam
/// let result = generation.new() |> generation.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches a generation given a generation resource.
///
/// # Example
///
/// ```gleam
/// let client = generation.new()
/// use res <- result.try(client |> generation.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> generation.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, generation())
}

/// Fetches a generation given the generation ID.
///
/// # Example
///
/// ```gleam
/// let result = generation.new() |> generation.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, generation())
}

/// Fetches a generation given the generation name.
///
/// # Example
///
/// ```gleam
/// let result = generation.new() |> generation.fetch_by_name("generation-i")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  client.fetch_by_name(client, path, name, generation())
}

fn generation() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use abilities <- decode.parameter
    use main_region <- decode.parameter
    use moves <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    use types <- decode.parameter
    use version_groups <- decode.parameter
    Generation(
      id,
      name,
      abilities,
      main_region,
      moves,
      names,
      pokemon_species,
      types,
      version_groups,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("abilities", decode.list(of: resource()))
  |> decode.field("main_region", resource())
  |> decode.field("moves", decode.list(of: resource()))
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: resource()))
  |> decode.field("types", decode.list(of: resource()))
  |> decode.field("version_groups", decode.list(of: resource()))
}
