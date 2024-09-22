import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/description.{type Description, description}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type ItemAttribute {
  ItemAttribute(
    id: Int,
    name: String,
    descriptions: List(Description),
    items: List(Resource),
    names: List(Name),
  )
}

const path = "item-attribute"

/// Fetches a list of item attribute resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = attribute.fetch(DefaultPagination)
/// let result = attribute.fetch(Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches an item attribute given an item attribute resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(attribute.fetch(DefaultPagination))
/// let assert Ok(first) = res.results |> list.first
/// attribute.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, item_attribute(), cache)
}

/// Fetches an item attribute given the item attribute ID.
///
/// # Example
///
/// ```gleam
/// let result = attribute.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, item_attribute(), cache)
}

/// Fetches an item attribute given the item attribute name.
///
/// # Example
///
/// ```gleam
/// let result = attribute.fetch_by_name("countable")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, item_attribute(), cache)
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
  |> decode.field("items", decode.list(of: resource()))
  |> decode.field("names", decode.list(of: name()))
}
