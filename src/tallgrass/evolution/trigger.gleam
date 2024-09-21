import decode

import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type EvolutionTrigger {
  EvolutionTrigger(
    id: Int,
    name: String,
    names: List(Name),
    pokemon_species: List(Resource),
  )
}

const path = "evolution-trigger"

/// Fetches a list of evolution trigger resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = trigger.fetch(options: Default)
/// let result = trigger.fetch(options: Some(PaginationOptions(limit: 100, offset: 0)))
/// ```
pub fn fetch(options options: PaginationOptions) {
  resource.fetch_resources(path, options)
}

/// Fetches an evolution trigger given an evolution trigger resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(trigger.fetch(options: Default))
/// let assert Ok(first) = res.results |> list.first
/// trigger.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: evolution_trigger())
}

/// Fetches an evolution trigger given the evolution trigger ID.
///
/// # Example
///
/// ```gleam
/// let result = trigger.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, evolution_trigger())
}

/// Fetches an evolution trigger given the evolution trigger name.
///
/// # Example
///
/// ```gleam
/// let result = trigger.fetch_by_name("level-up")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, evolution_trigger())
}

fn evolution_trigger() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    EvolutionTrigger(id, name, names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: resource()))
}
