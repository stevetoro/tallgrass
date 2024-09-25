import decode
import tallgrass/client.{type Client}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

pub type Version {
  Version(id: Int, name: String, names: List(Name), version_group: Resource)
}

const path = "version"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of version resources.
///
/// # Example
///
/// ```gleam
/// let result = version.new() |> version.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.client_fetch_resources(client, path)
}

/// Fetches a version given a version resource.
///
/// # Example
///
/// ```gleam
/// let client = version.new()
/// use res <- result.try(client |> version.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> version.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.client_fetch_resource(client, resource, version())
}

/// Fetches a version given the version ID.
///
/// # Example
///
/// ```gleam
/// let result = version.new() |> version.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.client_fetch_by_id(client, path, id, version())
}

/// Fetches a version given the version name.
///
/// # Example
///
/// ```gleam
/// let result = version.new() |> version.fetch_by_name("red")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.client_fetch_by_name(client, path, name, version())
}

fn version() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use version_group <- decode.parameter
    Version(id, name, names, version_group)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("version_group", resource())
}
