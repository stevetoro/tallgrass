import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/name.{type Name, name}

pub type ItemCategory {
  ItemCategory(
    id: Int,
    name: String,
    items: List(Affordance),
    names: List(Name),
    pocket: Affordance,
  )
}

pub fn item_category() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use items <- decode.parameter
    use names <- decode.parameter
    use pocket <- decode.parameter
    ItemCategory(id, name, items, names, pocket)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("items", decode.list(of: affordance()))
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pocket", affordance())
}
