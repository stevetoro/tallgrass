import decode
import tallgrass/client.{type Client}
import tallgrass/client/resource.{type Resource, resource}
import tallgrass/common/name.{type Name, name}

pub type EncounterConditionValue {
  EncounterConditionValue(
    id: Int,
    name: String,
    condition: Resource,
    names: List(Name),
  )
}

const path = "encounter-condition-value"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of encounter condition value resources.
///
/// # Example
///
/// ```gleam
/// let result = value |> method.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches an encounter condition value given an encounter condition value resource.
///
/// # Example
///
/// ```gleam
/// let client = value.new()
/// use res <- result.try(client |> value.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> value.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, encounter_condition_value())
}

/// Fetches an encounter condition value given the encounter condition value ID.
///
/// # Example
///
/// ```gleam
/// let result = value.new() |> value.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, encounter_condition_value())
}

/// Fetches an encounter condition value given the encounter condition value name.
///
/// # Example
///
/// ```gleam
/// let result = value.new() |> value.fetch_by_name("swarm-yes")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, encounter_condition_value())
}

fn encounter_condition_value() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use condition <- decode.parameter
    use names <- decode.parameter
    EncounterConditionValue(id, name, condition, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("condition", resource())
  |> decode.field("names", decode.list(of: name()))
}
