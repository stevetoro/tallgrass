import decode
import tallgrass/resource.{type Resource, resource}

pub type Machine {
  Machine(id: Int, item: Resource, move: Resource, version_group: Resource)
}

const path = "machine"

/// Fetches a machine by the machine ID.
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
