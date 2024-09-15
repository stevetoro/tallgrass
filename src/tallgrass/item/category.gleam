import decode
import tallgrass/fetch
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

const path = "item-category"

/// Fetches an item_category by the item_category ID.
///
/// # Example
///
/// ```gleam
/// let result = item_category.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, item_category())
}

/// Fetches an item_category by the item_category name.
///
/// # Example
///
/// ```gleam
/// let result = item_category.fetch_by_name("stat-boosts")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, item_category())
}

fn item_category() {
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
