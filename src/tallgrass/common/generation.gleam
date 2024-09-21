import decode
import tallgrass/resource.{type Resource, resource}

pub type GenerationGameIndex {
  GenerationGameIndex(index: Int, generation: Resource)
}

@internal
pub fn generation_game_index() {
  decode.into({
    use index <- decode.parameter
    use generation <- decode.parameter
    GenerationGameIndex(index, generation)
  })
  |> decode.field("game_index", decode.int)
  |> decode.field("generation", resource())
}
