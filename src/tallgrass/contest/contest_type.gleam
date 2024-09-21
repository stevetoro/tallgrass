import decode
import gleam/option.{type Option}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type ContestType {
  ContestType(id: Int, name: String, berry_flavor: Resource, names: List(Name))
}

const path = "contest-type"

/// Fetches a list of contest type resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = contest_type.fetch(options: None)
/// let result = contest_type.fetch(options: Some(PaginationOptions(limit: 100, offset: 0)))
/// ```
pub fn fetch(options options: Option(PaginationOptions)) {
  resource.fetch_resources(path, options)
}

/// Fetches a contest type given a contest type resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(contest_type.fetch(options: None))
/// let assert Ok(first) = res.results |> list.first
/// contest_type.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: contest_type())
}

/// Fetches a contest type given the contest type ID.
///
/// # Example
///
/// ```gleam
/// let result = contest_type.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, contest_type())
}

/// Fetches a contest type given the contest type name.
///
/// # Example
///
/// ```gleam
/// let result = contest_type.fetch_by_name("cool")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, contest_type())
}

fn contest_type() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use berry_flavor <- decode.parameter
    use names <- decode.parameter
    ContestType(id, name, berry_flavor, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("berry_flavor", resource())
  |> decode.field("names", decode.list(of: name()))
}
