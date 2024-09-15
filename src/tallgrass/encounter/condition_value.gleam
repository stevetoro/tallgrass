import decode
import tallgrass/fetch
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

const path = "encounter-condition-value"

/// Fetches an encounter condition value by ID.
///
/// # Example
///
/// ```gleam
/// let result = encounter_condition_value.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, encounter_condition_value())
}

/// Fetches an encounter condition value by name.
///
/// # Example
///
/// ```gleam
/// let result = encounter_condition_value.fetch_by_name("swarm-yes")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, encounter_condition_value())
}

fn encounter_condition_value() {
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
