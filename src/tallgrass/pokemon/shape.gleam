import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/name.{type Name, Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type PokemonShape {
  PokemonShape(
    id: Int,
    name: String,
    names: List(Name),
    awesome_names: List(Name),
    pokemon_species: List(Resource),
  )
}

const path = "pokemon-shape"

/// Fetches a list of pokemon shape resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = shape.fetch(DefaultPagination)
/// let result = shape.fetch(Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a pokemon shape given a pokemon shape resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(shape.fetch(DefaultPagination))
/// let assert Ok(first) = res.results |> list.first
/// shape.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, pokemon_shape(), cache)
}

/// Fetches a pokemon shape given the pokemon shape ID.
///
/// # Example
///
/// ```gleam
/// let result = shape.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, pokemon_shape(), cache)
}

/// Fetches a pokemon shape given the pokemon shape ID.
///
/// # Example
///
/// ```gleam
/// let result = shape.fetch_by_name("ball")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, pokemon_shape(), cache)
}

fn pokemon_shape() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use awesome_names <- decode.parameter
    use pokemon_species <- decode.parameter
    PokemonShape(id, name, names, awesome_names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("awesome_names", decode.list(of: awesome_name()))
  |> decode.field("pokemon_species", decode.list(of: resource()))
}

fn awesome_name() {
  decode.into({
    use name <- decode.parameter
    use language <- decode.parameter
    Name(name, language)
  })
  |> decode.field("awesome_name", decode.string)
  |> decode.field("language", resource())
}
