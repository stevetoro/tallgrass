import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type EncounterConditionValue {
  EncounterConditionValue(
    id: Int,
    name: String,
    condition: Resource,
    names: List(Name),
  )
}

const path = "encounter-condition-value"

/// Fetches a list of encounter condition value resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = value.fetch(DefaultPagination)
/// let result = value.fetch(Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches an encounter condition value given an encounter condition value resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(value.fetch(DefaultPagination))
/// let assert Ok(first) = res.results |> list.first
/// value.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, encounter_condition_value(), cache)
}

/// Fetches an encounter condition value given the encounter condition value ID.
///
/// # Example
///
/// ```gleam
/// let result = value.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, encounter_condition_value(), cache)
}

/// Fetches an encounter condition value given the encounter condition value name.
///
/// # Example
///
/// ```gleam
/// let result = value.fetch_by_name("swarm-yes")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, encounter_condition_value(), cache)
}

fn encounter_condition_value() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use condition <- decode.parameter
    use names <- decode.parameter
    EncounterConditionValue(id, name, condition, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("condition", resource())
  |> decode.field("names", decode.list(of: name()))
}
