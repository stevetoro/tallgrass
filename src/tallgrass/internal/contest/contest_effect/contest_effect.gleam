import decode
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}

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

pub type FlavorText {
  FlavorText(text: String, language: Affordance)
}

pub fn contest_effect() {
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

fn flavor_text() {
  decode.into({
    use text <- decode.parameter
    use language <- decode.parameter
    FlavorText(text, language)
  })
  |> decode.field("flavor_text", decode.string)
  |> decode.field("language", affordance())
}
