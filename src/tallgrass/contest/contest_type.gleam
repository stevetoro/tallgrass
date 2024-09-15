import decode
import tallgrass/fetch
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}
import tallgrass/internal/common/name.{type Name, name}

pub type ContestType {
  ContestType(
    id: Int,
    name: String,
    berry_flavor: Affordance,
    names: List(Name),
  )
}

const path = "contest-type"

/// Fetches a contest type by the type ID.
///
/// # Example
///
/// ```gleam
/// let result = contest_type.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, contest_type())
}

/// Fetches a contest type by the type name.
///
/// # Example
///
/// ```gleam
/// let result = contest_type.fetch_by_name("cool")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, contest_type())
}

fn contest_type() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use berry_flavor <- decode.parameter
    use names <- decode.parameter
    ContestType(id, name, berry_flavor, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("berry_flavor", affordance())
  |> decode.field("names", decode.list(of: name()))
}
