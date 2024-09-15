import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/name.{type Name, name}
import tallgrass/fetch

pub type EncounterCondition {
  EncounterCondition(
    id: Int,
    name: String,
    values: List(Affordance),
    names: List(Name),
  )
}

const path = "encounter-condition"

/// Fetches an encounter condition by the condition ID.
///
/// # Example
///
/// ```gleam
/// let result = encounter_condition.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, encounter_condition())
}

/// Fetches an encounter condition by the condition name.
///
/// # Example
///
/// ```gleam
/// let result = encounter_condition.fetch_by_name("swarm")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, encounter_condition())
}

fn encounter_condition() {
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
