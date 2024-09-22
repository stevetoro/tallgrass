import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource}

pub type EncounterMethod {
  EncounterMethod(id: Int, name: String, order: Int, names: List(Name))
}

const path = "encounter-method"

/// Fetches a list of encounter method resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = method.fetch(DefaultPagination, NoCache)
/// let result = method.fetch(Paginate(limit: 100, offset: 0), NoCache)
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches an encounter method given an encounter method resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(method.fetch(DefaultPagination, NoCache))
/// let assert Ok(first) = res.results |> list.first
/// method.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, encounter_method(), cache)
}

/// Fetches an encounter method given the encounter method ID.
///
/// # Example
///
/// ```gleam
/// let result = method.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, encounter_method(), cache)
}

/// Fetches an encounter method given the encounter method name.
///
/// # Example
///
/// ```gleam
/// let result = method.fetch_by_name("walk")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, encounter_method(), cache)
}

fn encounter_method() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use order <- decode.parameter
    use names <- decode.parameter
    EncounterMethod(id, name, order, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("order", decode.int)
  |> decode.field("names", decode.list(of: name()))
}
