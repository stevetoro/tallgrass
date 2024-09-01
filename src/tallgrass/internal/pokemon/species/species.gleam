import decode
import tallgrass/internal/common/affordance.{type Affordance, Affordance, affordance}
import tallgrass/internal/common/name.{type Name, Name, name}

pub type Species {
  Species(
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
    growth_rate: Affordance,
    egg_groups: List(Affordance),
    color: Affordance,
    shape: Affordance,
    evolves_from_species: Affordance,
    generation: Affordance,
    names: List(Name),
  )
}

pub fn species() {
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
    Species(
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
  |> decode.field("growth_rate", affordance())
  |> decode.field("egg_groups", decode.list(of: affordance()))
  |> decode.field("color", affordance())
  |> decode.field("shape", affordance())
  |> decode.field("evolves_from_species", affordance())
  |> decode.field("generation", affordance())
  |> decode.field("names", decode.list(of: name()))
}
