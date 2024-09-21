import decode
import gleam/option.{type Option}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type EggGroup {
  EggGroup(
    id: Int,
    name: String,
    names: List(Name),
    pokemon_species: List(Resource),
  )
}

const path = "egg-group"

/// Fetches a list of pokemon egg group resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = egg_group.fetch(options: None)
/// let result = egg_group.fetch(options: Some(PaginationOptions(limit: 100, offset: 0)))
/// ```
pub fn fetch(options options: Option(PaginationOptions)) {
  resource.fetch_resources(path, options)
}

/// Fetches a pokemon egg group given a pokemon egg group resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(egg_group.fetch(options: None))
/// let assert Ok(first) = res.results |> list.first
/// egg_group.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: egg_group())
}

/// Fetches a pokemon egg group given the pokemon egg group ID.
///
/// # Example
///
/// ```gleam
/// let result = egg_group.fetch_by_id(13)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, egg_group())
}

/// Fetches a pokemon egg group given the pokemon egg group name.
///
/// # Example
///
/// ```gleam
/// let result = egg_group.fetch_by_name("ditto")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, egg_group())
}

fn egg_group() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    EggGroup(id, name, names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: resource()))
}
