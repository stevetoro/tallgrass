import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

pub type ItemCategory {
  ItemCategory(
    id: Int,
    name: String,
    items: List(Resource),
    names: List(Name),
    pocket: Resource,
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
  resource.fetch_by_id(id, path, item_category())
}

/// Fetches an item_category by the item_category name.
///
/// # Example
///
/// ```gleam
/// let result = item_category.fetch_by_name("stat-boosts")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, item_category())
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
  |> decode.field("items", decode.list(of: resource()))
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pocket", resource())
}
