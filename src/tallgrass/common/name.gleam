import decode
import tallgrass/client/resource.{type Resource, resource}

pub type Name {
  Name(name: String, language: Resource)
}

@internal
pub fn name() {
  decode.into({
    use name <- decode.parameter
    use language <- decode.parameter
    Name(name, language)
  })
  |> decode.field("name", decode.string)
  |> decode.field("language", resource())
}
