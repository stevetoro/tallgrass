import decode
import tallgrass/resource.{type NamedResource, named_resource}

pub type Machine {
  Machine(
    id: Int,
    item: NamedResource,
    move: NamedResource,
    version_group: NamedResource,
  )
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
  |> decode.field("item", named_resource())
  |> decode.field("move", named_resource())
  |> decode.field("version_group", named_resource())
}
