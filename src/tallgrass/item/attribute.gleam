import decode
import tallgrass/fetch
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

const path = "item-attribute"

/// Fetches an item_attribute by the item_attribute ID.
///
/// # Example
///
/// ```gleam
/// let result = item_attribute.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, item_attribute())
}

/// Fetches an item_attribute by the item_attribute name.
///
/// # Example
///
/// ```gleam
/// let result = item_attribute.fetch_by_name("countable")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, item_attribute())
}

fn item_attribute() {
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
