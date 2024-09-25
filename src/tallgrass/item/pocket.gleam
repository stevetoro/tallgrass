import decode
import tallgrass/client.{type Client}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

pub type ItemPocket {
  ItemPocket(
    id: Int,
    name: String,
    categories: List(Resource),
    names: List(Name),
  )
}

const path = "item-pocket"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of item pocket resources.
///
/// # Example
///
/// ```gleam
/// let result = pocket.new() |> pocket.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches an item pocket given an item pocket resource.
///
/// # Example
///
/// ```gleam
/// let client = pocket.new()
/// use res <- result.try(client |> pocket.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> pocket.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, item_pocket())
}

/// Fetches an item pocket given the item pocket ID.
///
/// # Example
///
/// ```gleam
/// let result = pocket.new() |> pocket.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, item_pocket())
}

/// Fetches an item pocket given the item pocket name.
///
/// # Example
///
/// ```gleam
/// let result = pocket.new() |> pocket.fetch_by_name("misc")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, item_pocket())
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
