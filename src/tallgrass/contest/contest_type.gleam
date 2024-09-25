import decode
import tallgrass/client.{type Client}
import tallgrass/client/resource.{type Resource, resource}
import tallgrass/common/name.{type Name, name}

pub type ContestType {
  ContestType(id: Int, name: String, berry_flavor: Resource, names: List(Name))
}

const path = "contest-type"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of contest type resources.
///
/// # Example
///
/// ```gleam
/// let result = contest_type.new() |> contest_type.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches a contest type given a contest type resource.
///
/// # Example
///
/// ```gleam
/// let client = contest_type.new()
/// use res <- result.try(client |> contest_type.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> contest_type.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, contest_type())
}

/// Fetches a contest type given the contest type ID.
///
/// # Example
///
/// ```gleam
/// let result = contest_type.new() |> contest_type.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, contest_type())
}

/// Fetches a contest type given the contest type name.
///
/// # Example
///
/// ```gleam
/// let result = contest_type.new() |> contest_type.fetch_by_name("cool")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, contest_type())
}

fn contest_type() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use berry_flavor <- decode.parameter
    use names <- decode.parameter
    ContestType(id, name, berry_flavor, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("berry_flavor", resource())
  |> decode.field("names", decode.list(of: name()))
}
