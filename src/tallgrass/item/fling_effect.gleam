import decode
import tallgrass/client.{type Client}
import tallgrass/common/resource.{type Resource, resource}
import tallgrass/common/effect.{type Effect, effect}

pub type ItemFlingEffect {
  ItemFlingEffect(
    id: Int,
    name: String,
    effect_entries: List(Effect),
    items: List(Resource),
  )
}

const path = "item-fling-effect"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of item fling effect resources.
///
/// # Example
///
/// ```gleam
/// let result = fling_effect.new() |> fling_effect.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches an item fling effect given an item fling effect resource.
///
/// # Example
///
/// ```gleam
/// let client = fling_effect.new()
/// use res <- result.try(client |> fling_effect.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> fling_effect.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, item_fling_effect())
}

/// Fetches an item fling effect given the item fling effect ID.
///
/// # Example
///
/// ```gleam
/// let result = fling_effect.new() |> fling_effect.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, item_fling_effect())
}

/// Fetches an item fling effect given the item fling effect name.
///
/// # Example
///
/// ```gleam
/// let result = fling_effect.new() |> fling_effect.fetch_by_name("badly-poison")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  client.fetch_by_name(client, path, name, item_fling_effect())
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
