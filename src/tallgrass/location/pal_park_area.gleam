import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource}

// TODO: Add support for pokemon_encounters.

pub type PalParkArea {
  PalParkArea(id: Int, name: String, names: List(Name))
}

const path = "pal-park-area"

/// Fetches a list of pal park area resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = pal_park_area.fetch(DefaultPagination)
/// let result = pal_park_area.fetch(Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a pal park area given a pal park area resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(pal_park_area.fetch(DefaultPagination))
/// let assert Ok(first) = res.results |> list.first
/// pal_park_area.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, pal_park_area(), cache)
}

/// Fetches a pal park area given the pal park area ID.
///
/// # Example
///
/// ```gleam
/// let result = pal_park_area.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, pal_park_area(), cache)
}

/// Fetches a pal park area given the pal park area name.
///
/// # Example
///
/// ```gleam
/// let result = pal_park_area.fetch_by_name("forest")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, pal_park_area(), cache)
}

fn pal_park_area() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    PalParkArea(id, name, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
}
