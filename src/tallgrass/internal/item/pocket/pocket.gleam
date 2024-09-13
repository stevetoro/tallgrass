import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/name.{type Name, name}

pub type ItemPocket {
  ItemPocket(
    id: Int,
    name: String,
    categories: List(Affordance),
    names: List(Name),
  )
}

pub fn item_pocket() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use categories <- decode.parameter
    use names <- decode.parameter
    ItemPocket(id, name, categories, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("categories", decode.list(of: affordance()))
  |> decode.field("names", decode.list(of: name()))
}
