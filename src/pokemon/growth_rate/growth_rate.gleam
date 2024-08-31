import common/affordance.{type Affordance, Affordance, affordance}
import common/description.{type Description, description}
import decode

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

pub fn growth_rate() {
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
