import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type ItemPocket {
  ItemPocket(
    id: Int,
    name: String,
    categories: List(Resource),
    names: List(Name),
  )
}

const path = "item-pocket"

/// Fetches a list of item pocket resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = pocket.fetch(DefaultPagination, NoCache)
/// let result = pocket.fetch(Paginate(limit: 100, offset: 0), NoCache)
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches an item pocket given an item pocket resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(pocket.fetch(DefaultPagination, NoCache))
/// let assert Ok(first) = res.results |> list.first
/// pocket.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, item_pocket(), cache)
}

/// Fetches an item pocket given the item pocket ID.
///
/// # Example
///
/// ```gleam
/// let result = pocket.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, item_pocket(), cache)
}

/// Fetches an item pocket given the item pocket name.
///
/// # Example
///
/// ```gleam
/// let result = pocket.fetch_by_name("misc")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, item_pocket(), cache)
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
  |> decode.field("categories", decode.list(of: resource()))
  |> decode.field("names", decode.list(of: name()))
}
