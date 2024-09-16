import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type NamedResource, named_resource}

pub type ItemPocket {
  ItemPocket(
    id: Int,
    name: String,
    categories: List(NamedResource),
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
  resource.fetch_by_id(id, path, item_pocket())
}

/// Fetches an item_pocket by the item_pocket name.
///
/// # Example
///
/// ```gleam
/// let result = item_pocket.fetch_by_name("misc")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, item_pocket())
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
  |> decode.field("categories", decode.list(of: named_resource()))
  |> decode.field("names", decode.list(of: name()))
}
