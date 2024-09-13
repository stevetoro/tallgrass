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

pub type FlavorTextWithVersionGroup {
  FlavorTextWithVersionGroup(
    text: String,
    language: Affordance,
    version_group: Affordance,
  )
}

pub fn flavor_text_with_version_group(field text: String) {
  decode.into({
    use text <- decode.parameter
    use language <- decode.parameter
    use version_group <- decode.parameter
    FlavorTextWithVersionGroup(text, language, version_group)
  })
  |> decode.field(text, decode.string)
  |> decode.field("language", affordance())
  |> decode.field("version_group", affordance())
}
