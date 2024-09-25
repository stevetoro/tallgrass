import decode
import tallgrass/client.{type Client}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

pub type BerryFlavor {
  BerryFlavor(
    id: Int,
    name: String,
    berries: List(FlavorBerryMap),
    contest_type: Resource,
    names: List(Name),
  )
}

pub type FlavorBerryMap {
  FlavorBerryMap(potency: Int, berry: Resource)
}

const path = "berry-flavor"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of berry flavor resources.
///
/// # Example
///
/// ```gleam
/// let result = flavor.new() |> flavor.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches a berry flavor given a berry flavor resource.
///
/// # Example
///
/// ```gleam
/// let client = flavor.new()
/// use res <- result.try(client |> flavor.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> flavor.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, berry_flavor())
}

/// Fetches a berry flavor given the berry flavor ID.
///
/// # Example
///
/// ```gleam
/// let result = flavor.new() |> flavor.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, berry_flavor())
}

/// Fetches a berry flavor given the berry flavor name.
///
/// # Example
///
/// ```gleam
/// let result = flavor.new() |> flavor.fetch_by_name("spicy")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, berry_flavor())
}

fn berry_flavor() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use berries <- decode.parameter
    use contest_type <- decode.parameter
    use names <- decode.parameter
    BerryFlavor(id, name, berries, contest_type, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("berries", decode.list(of: flavor_berry_map()))
  |> decode.field("contest_type", resource())
  |> decode.field("names", decode.list(of: name()))
}

fn flavor_berry_map() {
  decode.into({
    use potency <- decode.parameter
    use berry <- decode.parameter
    FlavorBerryMap(potency, berry)
  })
  |> decode.field("potency", decode.int)
  |> decode.field("berry", resource())
}
