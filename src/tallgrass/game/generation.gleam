import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type Generation {
  Generation(
    id: Int,
    name: String,
    abilities: List(Resource),
    main_region: Resource,
    moves: List(Resource),
    names: List(Name),
    pokemon_species: List(Resource),
    types: List(Resource),
    version_groups: List(Resource),
  )
}

const path = "generation"

/// Fetches a list of generation resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = generation.fetch(DefaultPagination, NoCache)
/// let result = generation.fetch(Paginate(limit: 100, offset: 0), NoCache)
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a generation given a generation resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(generation.fetch(DefaultPagination, NoCache))
/// let assert Ok(first) = res.results |> list.first
/// generation.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, generation(), cache)
}

/// Fetches a generation given the generation ID.
///
/// # Example
///
/// ```gleam
/// let result = generation.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, generation(), cache)
}

/// Fetches a generation given the generation name.
///
/// # Example
///
/// ```gleam
/// let result = generation.fetch_by_name("generation-i")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, generation(), cache)
}

fn generation() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use abilities <- decode.parameter
    use main_region <- decode.parameter
    use moves <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    use types <- decode.parameter
    use version_groups <- decode.parameter
    Generation(
      id,
      name,
      abilities,
      main_region,
      moves,
      names,
      pokemon_species,
      types,
      version_groups,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("abilities", decode.list(of: resource()))
  |> decode.field("main_region", resource())
  |> decode.field("moves", decode.list(of: resource()))
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: resource()))
  |> decode.field("types", decode.list(of: resource()))
  |> decode.field("version_groups", decode.list(of: resource()))
}
