import decode
import tallgrass/cache.{type Cache}
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
/// let result = category.fetch(DefaultPagination, NoCache)
/// let result = category.fetch(Paginate(limit: 100, offset: 0), NoCache)
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches an item category given an item category resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(category.fetch(DefaultPagination, NoCache))
/// let assert Ok(first) = res.results |> list.first
/// category.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, item_category(), cache)
}

/// Fetches an item category given the item category ID.
///
/// # Example
///
/// ```gleam
/// let result = category.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, item_category(), cache)
}

/// Fetches an item category given the item category name.
///
/// # Example
///
/// ```gleam
/// let result = category.fetch_by_name("stat-boosts")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, item_category(), cache)
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
