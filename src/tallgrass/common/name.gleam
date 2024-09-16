import decode
import tallgrass/resource.{type NamedResource, named_resource}

pub type Name {
  Name(name: String, language: NamedResource)
}

@internal
pub fn name() {
  decode.into({
    use name <- decode.parameter
    use language <- decode.parameter
    Name(name, language)
  })
  |> decode.field("name", decode.string)
  |> decode.field("language", named_resource())
}
