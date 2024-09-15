import decode
import tallgrass/fetch
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/flavor_text.{type FlavorText, flavor_text}

pub type ContestEffect {
  ContestEffect(
    id: Int,
    appeal: Int,
    jam: Int,
    effect_entries: List(Effect),
    flavor_text_entries: List(FlavorText),
  )
}

pub type Effect {
  Effect(text: String, language: Affordance)
}

const path = "contest-effect"

/// Fetches a contest effect by the effect ID.
///
/// # Example
///
/// ```gleam
/// let result = contest_effect.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, contest_effect())
}

fn contest_effect() {
  decode.into({
    use id <- decode.parameter
    use appeal <- decode.parameter
    use jam <- decode.parameter
    use effects <- decode.parameter
    use flavor_text <- decode.parameter
    ContestEffect(id, appeal, jam, effects, flavor_text)
  })
  |> decode.field("id", decode.int)
  |> decode.field("appeal", decode.int)
  |> decode.field("jam", decode.int)
  |> decode.field("effect_entries", decode.list(of: effect()))
  |> decode.field("flavor_text_entries", decode.list(of: flavor_text()))
}

fn effect() {
  decode.into({
    use text <- decode.parameter
    use language <- decode.parameter
    Effect(text, language)
  })
  |> decode.field("effect", decode.string)
  |> decode.field("language", affordance())
}
