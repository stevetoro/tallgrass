import decode
import tallgrass/resource.{type NamedResource, named_resource}

pub type VersionGameIndex {
  VersionGameIndex(index: Int, version: NamedResource)
}

@internal
pub fn version_game_index() {
  decode.into({
    use index <- decode.parameter
    use version <- decode.parameter
    VersionGameIndex(index, version)
  })
  |> decode.field("game_index", decode.int)
  |> decode.field("version", named_resource())
}
