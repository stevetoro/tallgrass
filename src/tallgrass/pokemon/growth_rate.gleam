import decode
import tallgrass/common/description.{type Description, description}
import tallgrass/resource.{type NamedResource, named_resource}

pub type GrowthRate {
  GrowthRate(
    id: Int,
    name: String,
    formula: String,
    descriptions: List(Description),
    levels: List(GrowthRateExperienceLevel),
    pokemon_species: List(NamedResource),
  )
}

pub type GrowthRateExperienceLevel {
  GrowthRateExperienceLevel(level: Int, experience: Int)
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
  resource.fetch_by_id(id, path, growth_rate())
}

/// Fetches a pokemon growth rate by the growth rate name.
///
/// # Example
///
/// ```gleam
/// let result = growth_rate.fetch_by_name("slow")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, growth_rate())
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
  |> decode.field("pokemon_species", decode.list(of: named_resource()))
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
