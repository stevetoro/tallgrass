import decode
import tallgrass/resource.{type Resource, resource}

pub type Effect {
  Effect(effect: String, language: Resource)
}

@internal
pub fn effect() {
  decode.into({
    use effect <- decode.parameter
    use language <- decode.parameter
    Effect(effect, language)
  })
  |> decode.field("effect", decode.string)
  |> decode.field("language", resource())
}

pub type VerboseEffect {
  VerboseEffect(effect: String, short_effect: String, language: Resource)
}

@internal
pub fn verbose_effect() {
  decode.into({
    use effect <- decode.parameter
    use short_effect <- decode.parameter
    use language <- decode.parameter
    VerboseEffect(effect, short_effect, language)
  })
  |> decode.field("effect", decode.string)
  |> decode.field("short_effect", decode.string)
  |> decode.field("language", resource())
}
