import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type BerryFirmness {
  BerryFirmness(
    id: Int,
    name: String,
    berries: List(Resource),
    names: List(Name),
  )
}

const path = "berry-firmness"

/// Fetches a list of berry firmness resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = firmness.fetch(DefaultPagination, NoCache)
/// let result = firmness.fetch(Paginate(limit: 100, offset: 0), NoCache)
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a berry firmness given a berry firmness resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(firmness.fetch(DefaultPagination, NoCache))
/// let assert Ok(first) = res.results |> list.first
/// firmness.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, berry_firmness(), cache)
}

/// Fetches a berry firmness given the berry firmness ID.
///
/// # Example
///
/// ```gleam
/// let result = firmness.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, berry_firmness(), cache)
}

/// Fetches a berry firmness given the berry firmness name.
///
/// # Example
///
/// ```gleam
/// let result = firmness.fetch_by_name("very-soft")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, berry_firmness(), cache)
}

fn berry_firmness() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use berries <- decode.parameter
    use names <- decode.parameter
    BerryFirmness(id, name, berries, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("berries", decode.list(of: resource()))
  |> decode.field("names", decode.list(of: name()))
}
