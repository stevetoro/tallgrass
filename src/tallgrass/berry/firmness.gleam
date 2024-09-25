import decode
import tallgrass/client.{type Client}
import tallgrass/common/name.{type Name, name}
import tallgrass/client/resource.{type Resource, resource}

pub type BerryFirmness {
  BerryFirmness(
    id: Int,
    name: String,
    berries: List(Resource),
    names: List(Name),
  )
}

const path = "berry-firmness"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of berry firmness resources.
///
/// # Example
///
/// ```gleam
/// let result = firmness.new() |> firmness.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches a berry firmness given a berry firmness resource.
///
/// # Example
///
/// ```gleam
/// let client = firmness.new()
/// use res <- result.try(client |> firmness.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> firmness.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, berry_firmness())
}

/// Fetches a berry firmness given the berry firmness ID.
///
/// # Example
///
/// ```gleam
/// let result = firmness.new() |> firmness.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, berry_firmness())
}

/// Fetches a berry firmness given the berry firmness name.
///
/// # Example
///
/// ```gleam
/// let result = firmness.new() |> firmness.fetch_by_name("very-soft")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, berry_firmness())
}

fn berry_firmness() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use berries <- decode.parameter
    use names <- decode.parameter
    BerryFirmness(id, name, berries, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("berries", decode.list(of: resource()))
  |> decode.field("names", decode.list(of: name()))
}
