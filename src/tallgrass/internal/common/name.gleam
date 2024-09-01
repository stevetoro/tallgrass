import decode
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}

pub type Name {
  Name(name: String, language: Affordance)
}

pub fn name() {
  decode.into({
    use name <- decode.parameter
    use language <- decode.parameter
    Name(name, language)
  })
  |> decode.field("name", decode.string)
  |> decode.field("language", affordance())
}
