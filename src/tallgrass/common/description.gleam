import decode
import tallgrass/client/resource.{type Resource, resource}

pub type Description {
  Description(text: String, language: Resource)
}

@internal
pub fn description() {
  decode.into({
    use text <- decode.parameter
    use language <- decode.parameter
    Description(text, language)
  })
  |> decode.field("description", decode.string)
  |> decode.field("language", resource())
}
