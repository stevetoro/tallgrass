import decode
import tallgrass/fetch
import tallgrass/internal/common/name.{type Name, name}

pub type EncounterMethod {
  EncounterMethod(id: Int, name: String, order: Int, names: List(Name))
}

const path = "encounter-method"

/// Fetches an encounter method by the method ID.
///
/// # Example
///
/// ```gleam
/// let result = encounter_method.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, encounter_method())
}

/// Fetches an encounter method by the method name.
///
/// # Example
///
/// ```gleam
/// let result = encounter_method.fetch_by_name("walk")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, encounter_method())
}

fn encounter_method() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use order <- decode.parameter
    use names <- decode.parameter
    EncounterMethod(id, name, order, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("order", decode.int)
  |> decode.field("names", decode.list(of: name()))
}
