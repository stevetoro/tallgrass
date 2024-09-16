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
