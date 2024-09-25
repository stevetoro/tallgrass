import decode
import tallgrass/client.{type Client}
import tallgrass/common/description.{type Description, description}
import tallgrass/resource.{type Resource, resource}

pub type GrowthRate {
  GrowthRate(
    id: Int,
    name: String,
    formula: String,
    descriptions: List(Description),
    levels: List(GrowthRateExperienceLevel),
    pokemon_species: List(Resource),
  )
}

pub type GrowthRateExperienceLevel {
  GrowthRateExperienceLevel(level: Int, experience: Int)
}

const path = "growth-rate"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of pokemon growth rate resources.
///
/// # Example
///
/// ```gleam
/// let result = growth_rate.new() |> growth_rate.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches a pokemon growth rate given a pokemon growth rate resource.
///
/// # Example
///
/// ```gleam
/// let client = growth_rate.new()
/// use res <- result.try(client |> growth_rate.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> growth_rate.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, growth_rate())
}

/// Fetches a pokemon growth rate given the pokemon growth rate ID.
///
/// # Example
///
/// ```gleam
/// let result = growth_rate.new() |> growth_rate.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, growth_rate())
}

/// Fetches a pokemon growth rate given the pokemon growth rate name.
///
/// # Example
///
/// ```gleam
/// let result = growth_rate.new() |> growth_rate.fetch_by_name("slow")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, growth_rate())
}

fn growth_rate() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use formula <- decode.parameter
    use descriptions <- decode.parameter
    use levels <- decode.parameter
    use pokemon_species <- decode.parameter
    GrowthRate(id, name, formula, descriptions, levels, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("formula", decode.string)
  |> decode.field("descriptions", decode.list(of: description()))
  |> decode.field("levels", decode.list(of: growth_rate_experience_level()))
  |> decode.field("pokemon_species", decode.list(of: resource()))
}

fn growth_rate_experience_level() {
  decode.into({
    use level <- decode.parameter
    use experience <- decode.parameter
    GrowthRateExperienceLevel(level, experience)
  })
  |> decode.field("level", decode.int)
  |> decode.field("experience", decode.int)
}
