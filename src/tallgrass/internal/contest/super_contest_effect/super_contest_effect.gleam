import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/flavor_text.{type FlavorText, flavor_text}

pub type SuperContestEffect {
  SuperContestEffect(
    id: Int,
    appeal: Int,
    flavor_text_entries: List(FlavorText),
    moves: List(Affordance),
  )
}

pub fn super_contest_effect() {
  decode.into({
    use id <- decode.parameter
    use appeal <- decode.parameter
    use flavor_texts <- decode.parameter
    use moves <- decode.parameter
    SuperContestEffect(id, appeal, flavor_texts, moves)
  })
  |> decode.field("id", decode.int)
  |> decode.field("appeal", decode.int)
  |> decode.field("flavor_text_entries", decode.list(of: flavor_text()))
  |> decode.field("moves", decode.list(of: affordance()))
}
