import decode
import tallgrass/resource.{type NamedResource, named_resource}

pub type FlavorText {
  FlavorText(text: String, language: NamedResource)
}

@internal
pub fn flavor_text() {
  decode.into({
    use text <- decode.parameter
    use language <- decode.parameter
    FlavorText(text, language)
  })
  |> decode.field("flavor_text", decode.string)
  |> decode.field("language", named_resource())
}

pub type FlavorTextVersionGroup {
  FlavorTextVersionGroup(
    text: String,
    language: NamedResource,
    version_group: NamedResource,
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
  |> decode.field("language", named_resource())
  |> decode.field("version_group", named_resource())
}
