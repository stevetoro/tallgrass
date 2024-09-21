import decode
import gleam/option.{type Option}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

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

/// Fetches a list of item category resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = category.fetch(options: None)
/// let result = category.fetch(options: Some(PaginationOptions(limit: 100, offset: 0)))
/// ```
pub fn fetch(options options: Option(PaginationOptions)) {
  resource.fetch_resources(path, options)
}

/// Fetches an item category given an item category resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(category.fetch(options: None))
/// let assert Ok(first) = res.results |> list.first
/// category.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: item_category())
}

/// Fetches an item category given the item category ID.
///
/// # Example
///
/// ```gleam
/// let result = category.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, item_category())
}

/// Fetches an item category given the item category name.
///
/// # Example
///
/// ```gleam
/// let result = category.fetch_by_name("stat-boosts")
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
