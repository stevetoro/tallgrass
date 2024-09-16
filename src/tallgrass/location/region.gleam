import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type NamedResource, named_resource}

pub type Region {
  Region(
    id: Int,
    name: String,
    locations: List(NamedResource),
    main_generation: NamedResource,
    names: List(Name),
    pokedexes: List(NamedResource),
    version_groups: List(NamedResource),
  )
}

const path = "region"

/// Fetches a region by the region ID.
///
/// # Example
///
/// ```gleam
/// let result = region.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, region())
}

/// Fetches a region by the region name.
///
/// # Example
///
/// ```gleam
/// let result = region.fetch_by_name("kanto")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, region())
}

fn region() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use locations <- decode.parameter
    use main_generation <- decode.parameter
    use names <- decode.parameter
    use pokedexes <- decode.parameter
    use version_groups <- decode.parameter
    Region(
      id,
      name,
      locations,
      main_generation,
      names,
      pokedexes,
      version_groups,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("locations", decode.list(of: named_resource()))
  |> decode.field("main_generation", named_resource())
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokedexes", decode.list(of: named_resource()))
  |> decode.field("version_groups", decode.list(of: named_resource()))
}
