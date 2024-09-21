import decode
import tallgrass/common/description.{type Description, description}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type Pokedex {
  Pokedex(
    id: Int,
    name: String,
    is_main_series: Bool,
    descriptions: List(Description),
    names: List(Name),
    pokemon_entries: List(PokemonEntry),
    region: Resource,
    version_groups: List(Resource),
  )
}

pub type PokemonEntry {
  PokemonEntry(entry: Int, species: Resource)
}

const path = "pokedex"

/// Fetches a list of pokedex resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = pokedex.fetch(options: Default)
/// let result = pokedex.fetch(options: Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options options: PaginationOptions) {
  resource.fetch_resources(path, options)
}

/// Fetches a pokedex given a pokedex resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(pokedex.fetch(options: Default))
/// let assert Ok(first) = res.results |> list.first
/// pokedex.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: pokedex())
}

/// Fetches a pokedex given the pokedex ID.
///
/// # Example
///
/// ```gleam
/// let result = pokedex.fetch_by_id(2)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, pokedex())
}

/// Fetches a pokedex given the pokedex name.
///
/// # Example
///
/// ```gleam
/// let result = pokedex.fetch_by_name("kanto")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, pokedex())
}

fn pokedex() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use is_main_series <- decode.parameter
    use descriptions <- decode.parameter
    use names <- decode.parameter
    use pokemon_entries <- decode.parameter
    use region <- decode.parameter
    use version_groups <- decode.parameter
    Pokedex(
      id,
      name,
      is_main_series,
      descriptions,
      names,
      pokemon_entries,
      region,
      version_groups,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("is_main_series", decode.bool)
  |> decode.field("descriptions", decode.list(of: description()))
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_entries", decode.list(of: pokemon_entry()))
  |> decode.field("region", resource())
  |> decode.field("version_groups", decode.list(of: resource()))
}

fn pokemon_entry() {
  decode.into({
    use entry <- decode.parameter
    use species <- decode.parameter
    PokemonEntry(entry, species)
  })
  |> decode.field("entry_number", decode.int)
  |> decode.field("pokemon_species", resource())
}
