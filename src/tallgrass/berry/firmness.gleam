import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type NamedResource, named_resource}

pub type BerryFirmness {
  BerryFirmness(
    id: Int,
    name: String,
    berries: List(NamedResource),
    names: List(Name),
  )
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
  resource.fetch_by_id(id, path, berry_firmness())
}

/// Fetches a berry firmness by the firmness name.
///
/// # Example
///
/// ```gleam
/// let result = berry_firmness.fetch_by_name("very-soft")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, berry_firmness())
}

fn berry_firmness() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use berries <- decode.parameter
    use names <- decode.parameter
    BerryFirmness(id, name, berries, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("berries", decode.list(of: named_resource()))
  |> decode.field("names", decode.list(of: name()))
}
