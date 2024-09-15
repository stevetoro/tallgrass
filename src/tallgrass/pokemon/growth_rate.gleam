import decode
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}
import tallgrass/internal/common/description.{type Description, description}
import tallgrass/fetch

pub type GrowthRate {
  GrowthRate(
    id: Int,
    name: String,
    formula: String,
    descriptions: List(Description),
    levels: List(Level),
    pokemon_species: List(Affordance),
  )
}

pub type Level {
  Level(level: Int, experience: Int)
}

const path = "growth-rate"

/// Fetches a pokemon growth rate by the growth rate ID.
///
/// # Example
///
/// ```gleam
/// let result = growth_rate.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, growth_rate())
}

/// Fetches a pokemon growth rate by the growth rate name.
///
/// # Example
///
/// ```gleam
/// let result = growth_rate.fetch_by_name("slow")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, growth_rate())
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
  |> decode.field("levels", decode.list(of: level()))
  |> decode.field("pokemon_species", decode.list(of: affordance()))
}

fn level() {
  decode.into({
    use level <- decode.parameter
    use experience <- decode.parameter
    Level(level, experience)
  })
  |> decode.field("level", decode.int)
  |> decode.field("experience", decode.int)
}
