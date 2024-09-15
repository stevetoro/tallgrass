import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/fetch

pub type Machine {
  Machine(
    id: Int,
    item: Affordance,
    move: Affordance,
    version_group: Affordance,
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
  fetch.resource_by_id(id, path, machine())
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
  |> decode.field("item", affordance())
  |> decode.field("move", affordance())
  |> decode.field("version_group", affordance())
}
