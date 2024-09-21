import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

pub type BerryFlavor {
  BerryFlavor(
    id: Int,
    name: String,
    berries: List(FlavorBerryMap),
    contest_type: Resource,
    names: List(Name),
  )
}

pub type FlavorBerryMap {
  FlavorBerryMap(potency: Int, berry: Resource)
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
  resource.fetch_by_id(id, path, berry_flavor())
}

/// Fetches a berry flavor by the flavor name.
///
/// # Example
///
/// ```gleam
/// let result = berry_flavor.fetch_by_name("spicy")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, berry_flavor())
}

fn berry_flavor() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use berries <- decode.parameter
    use contest_type <- decode.parameter
    use names <- decode.parameter
    BerryFlavor(id, name, berries, contest_type, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("berries", decode.list(of: flavor_berry_map()))
  |> decode.field("contest_type", resource())
  |> decode.field("names", decode.list(of: name()))
}

fn flavor_berry_map() {
  decode.into({
    use potency <- decode.parameter
    use berry <- decode.parameter
    FlavorBerryMap(potency, berry)
  })
  |> decode.field("potency", decode.int)
  |> decode.field("berry", resource())
}
