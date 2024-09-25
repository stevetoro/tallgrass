import decode
import tallgrass/client.{type Client}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

pub type Region {
  Region(
    id: Int,
    name: String,
    locations: List(Resource),
    main_generation: Resource,
    names: List(Name),
    pokedexes: List(Resource),
    version_groups: List(Resource),
  )
}

const path = "region"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of region resources.
///
/// # Example
///
/// ```gleam
/// let result = region.new() |> region.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches a region given a region resource.
///
/// # Example
///
/// ```gleam
/// let client = region.new()
/// use res <- result.try(client |> region.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> region.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, region())
}

/// Fetches a region given the region ID.
///
/// # Example
///
/// ```gleam
/// let result = region.new() |> region.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, region())
}

/// Fetches a region given the region name.
///
/// # Example
///
/// ```gleam
/// let result = region.new() |> region.fetch_by_name("kanto")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, region())
}

fn region() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use locations <- decode.parameter
    use main_generation <- decode.parameter
    use names <- decode.parameter
    use pokedexes <- decode.parameter
    use version_groups <- decode.parameter
    Region(
      id,
      name,
      locations,
      main_generation,
      names,
      pokedexes,
      version_groups,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("locations", decode.list(of: resource()))
  |> decode.field("main_generation", resource())
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokedexes", decode.list(of: resource()))
  |> decode.field("version_groups", decode.list(of: resource()))
}
