import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}

pub type Effect {
  Effect(effect: String, short_effect: String, language: Affordance)
}

pub fn effect() {
  decode.into({
    use effect <- decode.parameter
    use short_effect <- decode.parameter
    use language <- decode.parameter
    Effect(effect, short_effect, language)
  })
  |> decode.field("effect", decode.string)
  |> decode.field("short_effect", decode.string)
  |> decode.field("language", affordance())
}

pub type EffectEntry {
  EffectEntry(effect: String, language: Affordance)
}

pub fn effect_entry() {
  decode.into({
    use effect <- decode.parameter
    use language <- decode.parameter
    EffectEntry(effect, language)
  })
  |> decode.field("effect", decode.string)
  |> decode.field("language", affordance())
}
