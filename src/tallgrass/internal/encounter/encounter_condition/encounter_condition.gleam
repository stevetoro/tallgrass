import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/name.{type Name, name}

pub type EncounterCondition {
  EncounterCondition(
    id: Int,
    name: String,
    values: List(Affordance),
    names: List(Name),
  )
}

pub fn encounter_condition() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use values <- decode.parameter
    use names <- decode.parameter
    EncounterCondition(id, name, values, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("values", decode.list(of: affordance()))
  |> decode.field("names", decode.list(of: name()))
}
