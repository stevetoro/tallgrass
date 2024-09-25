import decode
import tallgrass/client.{type Client}
import tallgrass/resource.{type Resource, resource}

pub type Berry {
  Berry(
    id: Int,
    name: String,
    growth_time: Int,
    max_harvest: Int,
    natural_gift_power: Int,
    size: Int,
    smoothness: Int,
    soil_dryness: Int,
    firmness: Resource,
    flavors: List(BerryFlavorMap),
    item: Resource,
    natural_gift_type: Resource,
  )
}

pub type BerryFlavorMap {
  BerryFlavorMap(potency: Int, flavor: Resource)
}

const path = "berry"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of berry resources.
///
/// # Example
///
/// ```gleam
/// let result = berry.new() |> berry.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches a berry given a berry resource.
///
/// # Example
///
/// ```gleam
/// let client = berry.new()
/// use res <- result.try(client |> berry.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> berry.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, berry())
}

/// Fetches a berry given the berry ID.
///
/// # Example
///
/// ```gleam
/// let result = berry.new() |> berry.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, berry())
}

/// Fetches a berry given the berry name.
///
/// # Example
///
/// ```gleam
/// let result = berry.new() |> berry.fetch_by_name("cheri")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, berry())
}

fn berry() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use growth_time <- decode.parameter
    use max_harvest <- decode.parameter
    use natural_gift_power <- decode.parameter
    use size <- decode.parameter
    use smoothness <- decode.parameter
    use soil_dryness <- decode.parameter
    use firmness <- decode.parameter
    use flavors <- decode.parameter
    use item <- decode.parameter
    use natural_gift_type <- decode.parameter
    Berry(
      id,
      name,
      growth_time,
      max_harvest,
      natural_gift_power,
      size,
      smoothness,
      soil_dryness,
      firmness,
      flavors,
      item,
      natural_gift_type,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("growth_time", decode.int)
  |> decode.field("max_harvest", decode.int)
  |> decode.field("natural_gift_power", decode.int)
  |> decode.field("size", decode.int)
  |> decode.field("smoothness", decode.int)
  |> decode.field("soil_dryness", decode.int)
  |> decode.field("firmness", resource())
  |> decode.field("flavors", decode.list(of: berry_flavor_map()))
  |> decode.field("item", resource())
  |> decode.field("natural_gift_type", resource())
}

fn berry_flavor_map() {
  decode.into({
    use potency <- decode.parameter
    use berry <- decode.parameter
    BerryFlavorMap(potency, berry)
  })
  |> decode.field("potency", decode.int)
  |> decode.field("flavor", resource())
}
