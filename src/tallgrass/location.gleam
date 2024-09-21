import decode
import gleam/option.{type Option}
import tallgrass/common/generation.{
  type GenerationGameIndex, generation_game_index,
}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type Location {
  Location(
    id: Int,
    name: String,
    region: Resource,
    names: List(Name),
    game_indices: List(GenerationGameIndex),
    areas: List(Resource),
  )
}

const path = "location"

/// Fetches a list of location resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = location.fetch(options: None)
/// let result = location.fetch(options: Some(PaginationOptions(limit: 100, offset: 0)))
/// ```
pub fn fetch(options options: Option(PaginationOptions)) {
  resource.fetch_resources(path, options)
}

/// Fetches a location given a location resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(location.fetch(options: None))
/// let assert Ok(first) = res.results |> list.first
/// location.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: location())
}

/// Fetches a location given the location ID.
///
/// # Example
///
/// ```gleam
/// let result = location.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, location())
}

/// Fetches a location given the location name.
///
/// # Example
///
/// ```gleam
/// let result = location.fetch_by_name("canalave-city")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, location())
}

fn location() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use region <- decode.parameter
    use names <- decode.parameter
    use game_indices <- decode.parameter
    use areas <- decode.parameter
    Location(id, name, region, names, game_indices, areas)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("region", resource())
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("game_indices", decode.list(of: generation_game_index()))
  |> decode.field("areas", decode.list(of: resource()))
}
