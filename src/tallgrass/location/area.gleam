import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

// TODO: Add support for encounter_method_rates and pokemon_encounters.

pub type LocationArea {
  LocationArea(
    id: Int,
    name: String,
    game_index: Int,
    location: Resource,
    names: List(Name),
  )
}

const path = "location-area"

/// Fetches a list of location area resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = area.fetch(DefaultPagination, NoCache)
/// let result = area.fetch(Paginate(limit: 100, offset: 0), NoCache)
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a location area given a location area resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(area.fetch(DefaultPagination, NoCache))
/// let assert Ok(first) = res.results |> list.first
/// area.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, location_area(), cache)
}

/// Fetches a location area given the location area ID.
///
/// # Example
///
/// ```gleam
/// let result = area.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, location_area(), cache)
}

/// Fetches a location area given the location area name.
///
/// # Example
///
/// ```gleam
/// let result = area.fetch_by_name("canalave-city-area")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, location_area(), cache)
}

fn location_area() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use game_index <- decode.parameter
    use location <- decode.parameter
    use names <- decode.parameter
    LocationArea(id, name, game_index, location, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("game_index", decode.int)
  |> decode.field("location", resource())
  |> decode.field("names", decode.list(of: name()))
}
