import decode
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}
import tallgrass/internal/common/name.{type Name, name}
import tallgrass/fetch

pub type Firmness {
  Firmness(id: Int, name: String, berries: List(Affordance), names: List(Name))
}

const path = "berry-firmness"

/// Fetches a berry firmness by the firmness ID.
///
/// # Example
///
/// ```gleam
/// let result = berry_firmness.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, firmness())
}

/// Fetches a berry firmness by the firmness name.
///
/// # Example
///
/// ```gleam
/// let result = berry_firmness.fetch_by_name("very-soft")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, firmness())
}

fn firmness() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use berries <- decode.parameter
    use names <- decode.parameter
    Firmness(id, name, berries, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("berries", decode.list(of: affordance()))
  |> decode.field("names", decode.list(of: name()))
}
