import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/name.{type Name, name}

pub type EncounterConditionValue {
  EncounterConditionValue(
    id: Int,
    name: String,
    condition: Affordance,
    names: List(Name),
  )
}

pub fn encounter_condition_value() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use condition <- decode.parameter
    use names <- decode.parameter
    EncounterConditionValue(id, name, condition, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("condition", affordance())
  |> decode.field("names", decode.list(of: name()))
}
