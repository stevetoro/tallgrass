import common/affordance.{type Affordance, Affordance, affordance}
import decode

pub type Description {
  Description(text: String, language: Affordance)
}

pub fn description() {
  decode.into({
    use text <- decode.parameter
    use language <- decode.parameter
    Description(text, language)
  })
  |> decode.field("description", decode.string)
  |> decode.field("language", affordance())
}
