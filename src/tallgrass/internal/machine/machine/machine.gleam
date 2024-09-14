import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}

pub type Machine {
  Machine(
    id: Int,
    item: Affordance,
    move: Affordance,
    version_group: Affordance,
  )
}

pub fn machine() {
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
