import decode
import tallgrass/cache.{type Cache}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type VersionGroup {
  VersionGroup(
    id: Int,
    name: String,
    order: Int,
    generation: Resource,
    move_learn_methods: List(Resource),
    pokedexes: List(Resource),
    regions: List(Resource),
    versions: List(Resource),
  )
}

const path = "version-group"

/// Fetches a list of version group resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = version_group.fetch(options: Default)
/// let result = version_group.fetch(options: Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options options: PaginationOptions, cache cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a version group given a version group resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(version_group.fetch(options: Default))
/// let assert Ok(first) = res.results |> list.first
/// version_group.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, using: version_group(), cache: cache)
}

/// Fetches a version group given the version group ID.
///
/// # Example
///
/// ```gleam
/// let result = version_group.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, version_group(), cache: cache)
}

/// Fetches a version group given the version group name.
///
/// # Example
///
/// ```gleam
/// let result = version_group.fetch_by_name("red-blue")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, version_group(), cache: cache)
}

fn version_group() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use order <- decode.parameter
    use generation <- decode.parameter
    use move_learn_methods <- decode.parameter
    use pokedexes <- decode.parameter
    use regions <- decode.parameter
    use versions <- decode.parameter
    VersionGroup(
      id,
      name,
      order,
      generation,
      move_learn_methods,
      pokedexes,
      regions,
      versions,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("order", decode.int)
  |> decode.field("generation", resource())
  |> decode.field("move_learn_methods", decode.list(of: resource()))
  |> decode.field("pokedexes", decode.list(of: resource()))
  |> decode.field("regions", decode.list(of: resource()))
  |> decode.field("versions", decode.list(of: resource()))
}
