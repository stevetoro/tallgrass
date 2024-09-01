import decode
import pokegleam/common/affordance.{type Affordance, Affordance, affordance}

pub type GameIndexVersion {
  GameIndexVersion(index: Int, version: Affordance)
}

pub type GameIndexGeneration {
  GameIndexGeneration(index: Int, generation: Affordance)
}

pub fn game_index_version() {
  decode.into({
    use index <- decode.parameter
    use version <- decode.parameter
    GameIndexVersion(index, version)
  })
  |> decode.field("game_index", decode.int)
  |> decode.field("version", affordance())
}

pub fn game_index_generation() {
  decode.into({
    use index <- decode.parameter
    use generation <- decode.parameter
    GameIndexGeneration(index, generation)
  })
  |> decode.field("game_index", decode.int)
  |> decode.field("generation", affordance())
}
