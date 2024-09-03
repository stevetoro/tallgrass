import decode
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}
import tallgrass/internal/common/name.{type Name, name}

pub type Flavor {
  Flavor(
    id: Int,
    name: String,
    berries: List(Berry),
    contest_type: Affordance,
    names: List(Name),
  )
}

pub type Berry {
  Berry(potency: Int, berry: Affordance)
}

pub fn flavor() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use berries <- decode.parameter
    use contest_type <- decode.parameter
    use names <- decode.parameter
    Flavor(id, name, berries, contest_type, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("berries", decode.list(of: berry()))
  |> decode.field("contest_type", affordance())
  |> decode.field("names", decode.list(of: name()))
}

fn berry() {
  decode.into({
    use potency <- decode.parameter
    use berry <- decode.parameter
    Berry(potency, berry)
  })
  |> decode.field("potency", decode.int)
  |> decode.field("berry", affordance())
}
