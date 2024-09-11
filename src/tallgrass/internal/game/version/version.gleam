import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/name.{type Name, name}

pub type Version {
  Version(id: Int, name: String, names: List(Name), version_group: Affordance)
}

pub fn version() {
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
  |> decode.field("version_group", affordance())
}
