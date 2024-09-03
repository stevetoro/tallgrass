import decode
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}
import tallgrass/internal/common/name.{type Name, name}

pub type Firmness {
  Firmness(id: Int, name: String, berries: List(Affordance), names: List(Name))
}

pub fn firmness() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use berries <- decode.parameter
    use names <- decode.parameter
    Firmness(id, name, berries, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("berries", decode.list(of: affordance()))
  |> decode.field("names", decode.list(of: name()))
}
