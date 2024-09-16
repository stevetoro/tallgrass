import decode
import tallgrass/resource.{type NamedResource, named_resource}

pub type Description {
  Description(text: String, language: NamedResource)
}

@internal
pub fn description() {
  decode.into({
    use text <- decode.parameter
    use language <- decode.parameter
    Description(text, language)
  })
  |> decode.field("description", decode.string)
  |> decode.field("language", named_resource())
}
