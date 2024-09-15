import decode
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}
import tallgrass/internal/common/name.{type Name, name}
import tallgrass/fetch

pub type Flavor {
  Flavor(
    id: Int,
    name: String,
    berries: List(Berry),
    contest_type: Affordance,
    names: List(Name),
  )
}

pub type Berry {
  Berry(potency: Int, berry: Affordance)
}

const path = "berry-flavor"

/// Fetches a berry flavor by the flavor ID.
///
/// # Example
///
/// ```gleam
/// let result = berry_flavor.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, flavor())
}

/// Fetches a berry flavor by the flavor name.
///
/// # Example
///
/// ```gleam
/// let result = berry_flavor.fetch_by_name("spicy")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, flavor())
}

fn flavor() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use berries <- decode.parameter
    use contest_type <- decode.parameter
    use names <- decode.parameter
    Flavor(id, name, berries, contest_type, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("berries", decode.list(of: berry()))
  |> decode.field("contest_type", affordance())
  |> decode.field("names", decode.list(of: name()))
}

fn berry() {
  decode.into({
    use potency <- decode.parameter
    use berry <- decode.parameter
    Berry(potency, berry)
  })
  |> decode.field("potency", decode.int)
  |> decode.field("berry", affordance())
}
