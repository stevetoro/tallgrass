import decode
import tallgrass/fetch
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

const path = "item-pocket"

/// Fetches an item_pocket by the item_pocket ID.
///
/// # Example
///
/// ```gleam
/// let result = item_pocket.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, item_pocket())
}

/// Fetches an item_pocket by the item_pocket name.
///
/// # Example
///
/// ```gleam
/// let result = item_pocket.fetch_by_name("misc")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, item_pocket())
}

fn item_pocket() {
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
