import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type Habitat {
  Habitat(
    id: Int,
    name: String,
    names: List(Name),
    pokemon_species: List(Resource),
  )
}

const path = "pokemon-habitat"

/// Fetches a list of pokemon habitat resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = habitat.fetch(DefaultPagination)
/// let result = habitat.fetch(Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a pokemon habitat given a pokemon habitat resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(habitat.fetch(DefaultPagination))
/// let assert Ok(first) = res.results |> list.first
/// habitat.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, habitat(), cache)
}

/// Fetches a pokemon habitat given the pokemon habitat ID.
///
/// # Example
///
/// ```gleam
/// let result = habitat.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, habitat(), cache)
}

/// Fetches a pokemon habitat given the pokemon habitat name.
///
/// # Example
///
/// ```gleam
/// let result = habitat.fetch_by_name("cave")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, habitat(), cache)
}

fn habitat() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    Habitat(id, name, names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: resource()))
}
