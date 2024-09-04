import decode
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}

pub type FlavorText {
  FlavorText(text: String, language: Affordance)
}

pub fn flavor_text() {
  decode.into({
    use text <- decode.parameter
    use language <- decode.parameter
    FlavorText(text, language)
  })
  |> decode.field("flavor_text", decode.string)
  |> decode.field("language", affordance())
}
