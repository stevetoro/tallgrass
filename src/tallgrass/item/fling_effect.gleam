import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/effect.{type Effect, effect}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type ItemFlingEffect {
  ItemFlingEffect(
    id: Int,
    name: String,
    effect_entries: List(Effect),
    items: List(Resource),
  )
}

const path = "item-fling-effect"

/// Fetches a list of item fling effect resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = fling_effect.fetch(options: Default)
/// let result = fling_effect.fetch(options: Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options options: PaginationOptions, cache cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches an item fling effect given an item fling effect resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(fling_effect.fetch(options: Default))
/// let assert Ok(first) = res.results |> list.first
/// fling_effect.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, using: item_fling_effect(), cache: cache)
}

/// Fetches an item fling effect given the item fling effect ID.
///
/// # Example
///
/// ```gleam
/// let result = fling_effect.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, item_fling_effect(), cache: cache)
}

/// Fetches an item fling effect given the item fling effect name.
///
/// # Example
///
/// ```gleam
/// let result = fling_effect.fetch_by_name("badly-poison")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, item_fling_effect(), cache: cache)
}

fn item_fling_effect() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use effect_entries <- decode.parameter
    use items <- decode.parameter
    ItemFlingEffect(id, name, effect_entries, items)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("effect_entries", decode.list(of: effect()))
  |> decode.field("items", decode.list(of: resource()))
}
