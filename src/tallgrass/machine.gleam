import decode
import tallgrass/client.{type Client}
import tallgrass/common/resource.{type Resource, resource}

pub type Machine {
  Machine(id: Int, item: Resource, move: Resource, version_group: Resource)
}

const path = "machine"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of machine resources.
///
/// # Example
///
/// ```gleam
/// let result = machine.new() |> machine.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches a machine given a machine resource.
///
/// # Example
///
/// ```gleam
/// let client = machine.new()
/// use res <- result.try(client |> machine.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> machine.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, machine())
}

/// Fetches a machine given the machine ID.
///
/// # Example
///
/// ```gleam
/// let result = machine.new() |> machine.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, machine())
}

fn machine() {
  decode.into({
    use id <- decode.parameter
    use item <- decode.parameter
    use move <- decode.parameter
    use version_group <- decode.parameter
    Machine(id, item, move, version_group)
  })
  |> decode.field("id", decode.int)
  |> decode.field("item", resource())
  |> decode.field("move", resource())
  |> decode.field("version_group", resource())
}
