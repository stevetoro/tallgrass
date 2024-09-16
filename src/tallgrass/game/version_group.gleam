import decode
import tallgrass/resource.{type NamedResource, named_resource}

pub type VersionGroup {
  VersionGroup(
    id: Int,
    name: String,
    order: Int,
    generation: NamedResource,
    move_learn_methods: List(NamedResource),
    pokedexes: List(NamedResource),
    regions: List(NamedResource),
    versions: List(NamedResource),
  )
}

const path = "version-group"

/// Fetches a version_group by the version_group ID.
///
/// # Example
///
/// ```gleam
/// let result = version_group.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, version_group())
}

/// Fetches a version_group by the version_group name.
///
/// # Example
///
/// ```gleam
/// let result = version_group.fetch_by_name("red-blue")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, version_group())
}

fn version_group() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use order <- decode.parameter
    use generation <- decode.parameter
    use move_learn_methods <- decode.parameter
    use pokedexes <- decode.parameter
    use regions <- decode.parameter
    use versions <- decode.parameter
    VersionGroup(
      id,
      name,
      order,
      generation,
      move_learn_methods,
      pokedexes,
      regions,
      versions,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("order", decode.int)
  |> decode.field("generation", named_resource())
  |> decode.field("move_learn_methods", decode.list(of: named_resource()))
  |> decode.field("pokedexes", decode.list(of: named_resource()))
  |> decode.field("regions", decode.list(of: named_resource()))
  |> decode.field("versions", decode.list(of: named_resource()))
}
