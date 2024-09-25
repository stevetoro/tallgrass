import decode
import tallgrass/client.{type Client}
import tallgrass/common/name.{type Name, name}
import tallgrass/client/resource.{type Resource}

pub type EncounterMethod {
  EncounterMethod(id: Int, name: String, order: Int, names: List(Name))
}

const path = "encounter-method"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of encounter method resources.
///
/// # Example
///
/// ```gleam
/// let result = method |> method.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches an encounter method given an encounter method resource.
///
/// # Example
///
/// ```gleam
/// let client = method.new()
/// use res <- result.try(client |> method.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> method.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, encounter_method())
}

/// Fetches an encounter method given the encounter method ID.
///
/// # Example
///
/// ```gleam
/// let result = method.new() |> method.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, encounter_method())
}

/// Fetches an encounter method given the encounter method name.
///
/// # Example
///
/// ```gleam
/// let result = method.new() |> method.fetch_by_name("walk")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, encounter_method())
}

fn encounter_method() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use order <- decode.parameter
    use names <- decode.parameter
    EncounterMethod(id, name, order, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("order", decode.int)
  |> decode.field("names", decode.list(of: name()))
}
