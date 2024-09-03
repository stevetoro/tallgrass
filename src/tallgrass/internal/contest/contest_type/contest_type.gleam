import decode
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}
import tallgrass/internal/common/name.{type Name, name}

pub type ContestType {
  ContestType(
    id: Int,
    name: String,
    berry_flavor: Affordance,
    names: List(Name),
  )
}

pub fn contest_type() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use berry_flavor <- decode.parameter
    use names <- decode.parameter
    ContestType(id, name, berry_flavor, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("berry_flavor", affordance())
  |> decode.field("names", decode.list(of: name()))
}
