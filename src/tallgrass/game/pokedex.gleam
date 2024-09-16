import decode
import tallgrass/common/description.{type Description, description}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type NamedResource, named_resource}

pub type Pokedex {
  Pokedex(
    id: Int,
    name: String,
    is_main_series: Bool,
    descriptions: List(Description),
    names: List(Name),
    pokemon_entries: List(PokemonEntry),
    region: NamedResource,
    version_groups: List(NamedResource),
  )
}

pub type PokemonEntry {
  PokemonEntry(entry: Int, species: NamedResource)
}

const path = "pokedex"

/// Fetches a pokedex by the pokedex ID.
///
/// # Example
///
/// ```gleam
/// let result = pokedex.fetch_by_id(2)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, pokedex())
}

/// Fetches a pokedex by the pokedex name.
///
/// # Example
///
/// ```gleam
/// let result = pokedex.fetch_by_name("kanto")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, pokedex())
}

fn pokedex() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use is_main_series <- decode.parameter
    use descriptions <- decode.parameter
    use names <- decode.parameter
    use pokemon_entries <- decode.parameter
    use region <- decode.parameter
    use version_groups <- decode.parameter
    Pokedex(
      id,
      name,
      is_main_series,
      descriptions,
      names,
      pokemon_entries,
      region,
      version_groups,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("is_main_series", decode.bool)
  |> decode.field("descriptions", decode.list(of: description()))
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_entries", decode.list(of: pokemon_entry()))
  |> decode.field("region", named_resource())
  |> decode.field("version_groups", decode.list(of: named_resource()))
}

fn pokemon_entry() {
  decode.into({
    use entry <- decode.parameter
    use species <- decode.parameter
    PokemonEntry(entry, species)
  })
  |> decode.field("entry_number", decode.int)
  |> decode.field("pokemon_species", named_resource())
}
