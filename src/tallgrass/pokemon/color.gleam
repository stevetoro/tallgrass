import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type PokemonColor {
  PokemonColor(
    id: Int,
    name: String,
    names: List(Name),
    pokemon_species: List(Resource),
  )
}

const path = "pokemon-color"

/// Fetches a list of pokemon color resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = color.fetch(options: Default)
/// let result = color.fetch(options: Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options options: PaginationOptions, cache cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a pokemon color given a pokemon color resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(color.fetch(options: Default))
/// let assert Ok(first) = res.results |> list.first
/// color.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, using: pokemon_color(), cache: cache)
}

/// Fetches a pokemon color given the pokemon color ID.
///
/// # Example
///
/// ```gleam
/// let result = color.fetch_by_id(9)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, pokemon_color(), cache: cache)
}

/// Fetches a pokemon color given the pokemon color name.
///
/// # Example
///
/// ```gleam
/// let result = color.fetch_by_name("white")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, pokemon_color(), cache: cache)
}

fn pokemon_color() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    PokemonColor(id, name, names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: resource()))
}
