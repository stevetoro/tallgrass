import decode
import tallgrass/client.{type Client}
import tallgrass/common/name.{type Name, name}
import tallgrass/common/resource.{type Resource, resource}

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

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of item category resources.
///
/// # Example
///
/// ```gleam
/// let result = category.new() |> category.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches an item category given an item category resource.
///
/// # Example
///
/// ```gleam
/// let client = category.new()
/// use res <- result.try(client |> category.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> category.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, item_category())
}

/// Fetches an item category given the item category ID.
///
/// # Example
///
/// ```gleam
/// let result = category.new() |> category.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, item_category())
}

/// Fetches an item category given the item category name.
///
/// # Example
///
/// ```gleam
/// let result = category.new() |> category.fetch_by_name("stat-boosts")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  client.fetch_by_name(client, path, name, item_category())
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
