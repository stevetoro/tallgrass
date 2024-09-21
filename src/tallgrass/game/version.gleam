import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type Version {
  Version(id: Int, name: String, names: List(Name), version_group: Resource)
}

const path = "version"

/// Fetches a list of version resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = version.fetch(options: Default)
/// let result = version.fetch(options: Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options options: PaginationOptions) {
  resource.fetch_resources(path, options)
}

/// Fetches a version given a version resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(version.fetch(options: Default))
/// let assert Ok(first) = res.results |> list.first
/// version.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: version())
}

/// Fetches a version given the version ID.
///
/// # Example
///
/// ```gleam
/// let result = version.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, version())
}

/// Fetches a version given the version name.
///
/// # Example
///
/// ```gleam
/// let result = version.fetch_by_name("red")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, version())
}

fn version() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use version_group <- decode.parameter
    Version(id, name, names, version_group)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("version_group", resource())
}
