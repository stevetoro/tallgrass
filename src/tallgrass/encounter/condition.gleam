import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type EncounterCondition {
  EncounterCondition(
    id: Int,
    name: String,
    values: List(Resource),
    names: List(Name),
  )
}

const path = "encounter-condition"

/// Fetches a list of encounter condition resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = condition.fetch(options: Default)
/// let result = condition.fetch(options: Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options options: PaginationOptions, cache cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches an encounter condition given an encounter condition resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(condition.fetch(options: Default))
/// let assert Ok(first) = res.results |> list.first
/// condition.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, using: encounter_condition(), cache: cache)
}

/// Fetches an encounter condition given the encounter condition ID.
///
/// # Example
///
/// ```gleam
/// let result = condition.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, encounter_condition(), cache: cache)
}

/// Fetches an encounter condition given the encounter condition name.
///
/// # Example
///
/// ```gleam
/// let result = condition.fetch_by_name("swarm")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, encounter_condition(), cache: cache)
}

fn encounter_condition() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use values <- decode.parameter
    use names <- decode.parameter
    EncounterCondition(id, name, values, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("values", decode.list(of: resource()))
  |> decode.field("names", decode.list(of: name()))
}
