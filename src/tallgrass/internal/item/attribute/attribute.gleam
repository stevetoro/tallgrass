import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/description.{type Description, description}
import tallgrass/internal/common/name.{type Name, name}

pub type ItemAttribute {
  ItemAttribute(
    id: Int,
    name: String,
    descriptions: List(Description),
    items: List(Affordance),
    names: List(Name),
  )
}

pub fn item_attribute() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use descriptions <- decode.parameter
    use items <- decode.parameter
    use names <- decode.parameter
    ItemAttribute(id, name, descriptions, items, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("descriptions", decode.list(of: description()))
  |> decode.field("items", decode.list(of: affordance()))
  |> decode.field("names", decode.list(of: name()))
}
