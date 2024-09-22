import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type Region {
  Region(
    id: Int,
    name: String,
    locations: List(Resource),
    main_generation: Resource,
    names: List(Name),
    pokedexes: List(Resource),
    version_groups: List(Resource),
  )
}

const path = "region"

/// Fetches a list of region resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = region.fetch(DefaultPagination)
/// let result = region.fetch(Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a region given a region resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(region.fetch(DefaultPagination))
/// let assert Ok(first) = res.results |> list.first
/// region.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, region(), cache)
}

/// Fetches a region given the region ID.
///
/// # Example
///
/// ```gleam
/// let result = region.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, region(), cache)
}

/// Fetches a region given the region name.
///
/// # Example
///
/// ```gleam
/// let result = region.fetch_by_name("kanto")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, region(), cache)
}

fn region() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use locations <- decode.parameter
    use main_generation <- decode.parameter
    use names <- decode.parameter
    use pokedexes <- decode.parameter
    use version_groups <- decode.parameter
    Region(
      id,
      name,
      locations,
      main_generation,
      names,
      pokedexes,
      version_groups,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("locations", decode.list(of: resource()))
  |> decode.field("main_generation", resource())
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokedexes", decode.list(of: resource()))
  |> decode.field("version_groups", decode.list(of: resource()))
}
