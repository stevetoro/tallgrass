import decode
import tallgrass/common/resource.{type Resource, resource}

pub type FlavorText {
  FlavorText(text: String, language: Resource)
}

@internal
pub fn flavor_text() {
  decode.into({
    use text <- decode.parameter
    use language <- decode.parameter
    FlavorText(text, language)
  })
  |> decode.field("flavor_text", decode.string)
  |> decode.field("language", resource())
}

pub type FlavorTextVersionGroup {
  FlavorTextVersionGroup(
    text: String,
    language: Resource,
    version_group: Resource,
  )
}

@internal
pub fn flavor_text_version_group() {
  decode.into({
    use text <- decode.parameter
    use language <- decode.parameter
    use version_group <- decode.parameter
    FlavorTextVersionGroup(text, language, version_group)
  })
  |> decode.field("flavor_text", decode.string)
  |> decode.field("language", resource())
  |> decode.field("version_group", resource())
}
