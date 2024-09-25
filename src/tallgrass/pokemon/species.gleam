import decode
import tallgrass/client.{type Client}
import tallgrass/client/resource.{type Resource, resource}
import tallgrass/common/name.{type Name, name}

pub type PokemonSpecies {
  PokemonSpecies(
    id: Int,
    name: String,
    order: Int,
    gender_rate: Int,
    capture_rate: Int,
    base_happiness: Int,
    is_baby: Bool,
    is_legendary: Bool,
    is_mythical: Bool,
    hatch_counter: Int,
    has_gender_differences: Bool,
    forms_switchable: Bool,
    growth_rate: Resource,
    egg_groups: List(Resource),
    color: Resource,
    shape: Resource,
    evolves_from_species: Resource,
    generation: Resource,
    names: List(Name),
  )
}

const path = "pokemon-species"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of pokemon species resources.
///
/// # Example
///
/// ```gleam
/// let result = species.new() |> species.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches a pokemon species given a pokemon species resource.
///
/// # Example
///
/// ```gleam
/// let client = species.new()
/// use res <- result.try(client |> species.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> species.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, pokemon_species())
}

/// Fetches a pokemon species given the pokemon species ID.
///
/// # Example
///
/// ```gleam
/// let result = species.new() |> species.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, pokemon_species())
}

/// Fetches a pokemon species given the pokemon species name.
///
/// # Example
///
/// ```gleam
/// let result = species.new() |> species.fetch_by_name("ditto")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, pokemon_species())
}

fn pokemon_species() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use order <- decode.parameter
    use gender_rate <- decode.parameter
    use capture_rate <- decode.parameter
    use base_happiness <- decode.parameter
    use is_baby <- decode.parameter
    use is_legendary <- decode.parameter
    use is_mythical <- decode.parameter
    use hatch_counter <- decode.parameter
    use has_gender_differences <- decode.parameter
    use forms_switchable <- decode.parameter
    use growth_rate <- decode.parameter
    use egg_groups <- decode.parameter
    use color <- decode.parameter
    use shape <- decode.parameter
    use evolves_from_species <- decode.parameter
    use generation <- decode.parameter
    use names <- decode.parameter
    PokemonSpecies(
      id,
      name,
      order,
      gender_rate,
      capture_rate,
      base_happiness,
      is_baby,
      is_legendary,
      is_mythical,
      hatch_counter,
      has_gender_differences,
      forms_switchable,
      growth_rate,
      egg_groups,
      color,
      shape,
      evolves_from_species,
      generation,
      names,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("order", decode.int)
  |> decode.field("gender_rate", decode.int)
  |> decode.field("capture_rate", decode.int)
  |> decode.field("base_happiness", decode.int)
  |> decode.field("is_baby", decode.bool)
  |> decode.field("is_legendary", decode.bool)
  |> decode.field("is_mythical", decode.bool)
  |> decode.field("hatch_counter", decode.int)
  |> decode.field("has_gender_differences", decode.bool)
  |> decode.field("forms_switchable", decode.bool)
  |> decode.field("growth_rate", resource())
  |> decode.field("egg_groups", decode.list(of: resource()))
  |> decode.field("color", resource())
  |> decode.field("shape", resource())
  |> decode.field("evolves_from_species", resource())
  |> decode.field("generation", resource())
  |> decode.field("names", decode.list(of: name()))
}
