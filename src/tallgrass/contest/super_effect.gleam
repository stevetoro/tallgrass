import decode
import tallgrass/fetch
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

const path = "super-contest-effect"

/// Fetches a super contest effect by the effect ID.
///
/// # Example
///
/// ```gleam
/// let result = super_contest_effect.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, super_contest_effect())
}

fn super_contest_effect() {
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
