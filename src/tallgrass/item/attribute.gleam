import decode
import tallgrass/client.{type Client}
import tallgrass/common/description.{type Description, description}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

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

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of item attribute resources.
///
/// # Example
///
/// ```gleam
/// let result = attribute.new() |> attribute.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.client_fetch_resources(client, path)
}

/// Fetches an item attribute given an item attribute resource.
///
/// # Example
///
/// ```gleam
/// let client = attribute.new()
/// use res <- result.try(client |> attribute.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> attribute.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.client_fetch_resource(client, resource, item_attribute())
}

/// Fetches an item attribute given the item attribute ID.
///
/// # Example
///
/// ```gleam
/// let result = attribute.new() |> attribute.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.client_fetch_by_id(client, path, id, item_attribute())
}

/// Fetches an item attribute given the item attribute name.
///
/// # Example
///
/// ```gleam
/// let result = attribute.new() |> attribute.fetch_by_name("countable")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.client_fetch_by_name(client, path, name, item_attribute())
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
