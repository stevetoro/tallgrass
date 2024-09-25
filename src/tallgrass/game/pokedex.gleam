import decode
import tallgrass/client.{type Client}
import tallgrass/common/description.{type Description, description}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

pub type Pokedex {
  Pokedex(
    id: Int,
    name: String,
    is_main_series: Bool,
    descriptions: List(Description),
    names: List(Name),
    pokemon_entries: List(PokemonEntry),
    region: Resource,
    version_groups: List(Resource),
  )
}

pub type PokemonEntry {
  PokemonEntry(entry: Int, species: Resource)
}

const path = "pokedex"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of pokedex resources.
///
/// # Example
///
/// ```gleam
/// let result = pokedex.new() |> pokedex.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.client_fetch_resources(client, path)
}

/// Fetches a pokedex given a pokedex resource.
///
/// # Example
///
/// ```gleam
/// let client = pokedex.new()
/// use res <- result.try(client |> pokedex.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> pokedex.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.client_fetch_resource(client, resource, pokedex())
}

/// Fetches a pokedex given the pokedex ID.
///
/// # Example
///
/// ```gleam
/// let result = pokedex.new() |> pokedex.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.client_fetch_by_id(client, path, id, pokedex())
}

/// Fetches a pokedex given the pokedex name.
///
/// # Example
///
/// ```gleam
/// let result = pokedex.new() |> pokedex.fetch_by_name("kanto")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.client_fetch_by_name(client, path, name, pokedex())
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
  |> decode.field("region", resource())
  |> decode.field("version_groups", decode.list(of: resource()))
}

fn pokemon_entry() {
  decode.into({
    use entry <- decode.parameter
    use species <- decode.parameter
    PokemonEntry(entry, species)
  })
  |> decode.field("entry_number", decode.int)
  |> decode.field("pokemon_species", resource())
}
