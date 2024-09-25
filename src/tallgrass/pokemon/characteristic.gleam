import decode
import tallgrass/client.{type Client}
import tallgrass/common/description.{type Description, description}
import tallgrass/resource.{type Resource, resource}

pub type Characteristic {
  Characteristic(
    id: Int,
    gene_modulo: Int,
    possible_values: List(Int),
    highest_stat: Resource,
    descriptions: List(Description),
  )
}

const path = "characteristic"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of pokemon characteristic resources.
///
/// # Example
///
/// ```gleam
/// let result = characteristic.new() |> characteristic.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches a pokemon characteristic given a pokemon characteristic resource.
///
/// # Example
///
/// ```gleam
/// let client = characteristic.new()
/// use res <- result.try(client |> characteristic.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> characteristic.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, characteristic())
}

/// Fetches a pokemon characteristic given the pokemon characteristic ID.
///
/// # Example
///
/// ```gleam
/// let result = characteristic.new() |> characteristic.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, characteristic())
}

fn characteristic() {
  decode.into({
    use id <- decode.parameter
    use gene_modulo <- decode.parameter
    use possible_values <- decode.parameter
    use highest_stat <- decode.parameter
    use descriptions <- decode.parameter
    Characteristic(id, gene_modulo, possible_values, highest_stat, descriptions)
  })
  |> decode.field("id", decode.int)
  |> decode.field("gene_modulo", decode.int)
  |> decode.field("possible_values", decode.list(of: decode.int))
  |> decode.field("highest_stat", resource())
  |> decode.field("descriptions", decode.list(of: description()))
}
