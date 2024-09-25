import decode
import tallgrass/client.{type Client}
import tallgrass/common/name.{type Name, name}
import tallgrass/client/resource.{type Resource, resource}

pub type EvolutionTrigger {
  EvolutionTrigger(
    id: Int,
    name: String,
    names: List(Name),
    pokemon_species: List(Resource),
  )
}

const path = "evolution-trigger"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of evolution trigger resources.
///
/// # Example
///
/// ```gleam
/// let result = trigger.new() |> trigger.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches an evolution trigger given an evolution trigger resource.
///
/// # Example
///
/// ```gleam
/// let client = trigger.new()
/// use res <- result.try(client |> trigger.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> trigger.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, evolution_trigger())
}

/// Fetches an evolution trigger given the evolution trigger ID.
///
/// # Example
///
/// ```gleam
/// let result = trigger.new() |> trigger.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, evolution_trigger())
}

/// Fetches an evolution trigger given the evolution trigger name.
///
/// # Example
///
/// ```gleam
/// let result = trigger.new() |> trigger.fetch_by_name("level-up")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, evolution_trigger())
}

fn evolution_trigger() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    EvolutionTrigger(id, name, names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: resource()))
}
