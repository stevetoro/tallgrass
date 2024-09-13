import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/effect.{type EffectEntry, effect_entry}

pub type ItemFlingEffect {
  ItemFlingEffect(
    id: Int,
    name: String,
    effect_entries: List(EffectEntry),
    items: List(Affordance),
  )
}

pub fn item_fling_effect() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use effect_entries <- decode.parameter
    use items <- decode.parameter
    ItemFlingEffect(id, name, effect_entries, items)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("effect_entries", decode.list(of: effect_entry()))
  |> decode.field("items", decode.list(of: affordance()))
}
