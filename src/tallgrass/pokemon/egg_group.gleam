import decode
import tallgrass/fetch
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}
import tallgrass/internal/common/name.{type Name, Name, name}

pub type EggGroup {
  EggGroup(
    id: Int,
    name: String,
    names: List(Name),
    pokemon_species: List(Affordance),
  )
}

const path = "egg-group"

/// Fetches a pokemon egg group by the egg group ID.
///
/// # Example
///
/// ```gleam
/// let result = egg_group.fetch_by_id(13)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, egg_group())
}

/// Fetches a pokemon egg group by the egg group name.
///
/// # Example
///
/// ```gleam
/// let result = egg_group.fetch_by_name("ditto")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, egg_group())
}

fn egg_group() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    EggGroup(id, name, names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: affordance()))
}
