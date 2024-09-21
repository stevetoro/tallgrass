import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

pub type Version {
  Version(id: Int, name: String, names: List(Name), version_group: Resource)
}

const path = "version"

/// Fetches a version by the version ID.
///
/// # Example
///
/// ```gleam
/// let result = version.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, version())
}

/// Fetches a version by the version name.
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
