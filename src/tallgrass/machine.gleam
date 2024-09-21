import decode
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type Machine {
  Machine(id: Int, item: Resource, move: Resource, version_group: Resource)
}

const path = "machine"

/// Fetches a list of machine resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = machine.fetch(options: Default)
/// let result = machine.fetch(options: Some(PaginationOptions(limit: 100, offset: 0)))
/// ```
pub fn fetch(options options: PaginationOptions) {
  resource.fetch_resources(path, options)
}

/// Fetches a machine given a machine resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(machine.fetch(options: Default))
/// let assert Ok(first) = res.results |> list.first
/// machine.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: machine())
}

/// Fetches a machine given the machine ID.
///
/// # Example
///
/// ```gleam
/// let result = machine.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, machine())
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
