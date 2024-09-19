import decode
import tallgrass/resource.{type NamedResource, named_resource}

pub type Berry {
  Berry(
    id: Int,
    name: String,
    growth_time: Int,
    max_harvest: Int,
    natural_gift_power: Int,
    size: Int,
    smoothness: Int,
    soil_dryness: Int,
    firmness: NamedResource,
    flavors: List(BerryFlavorMap),
    item: NamedResource,
    natural_gift_type: NamedResource,
  )
}

pub type BerryFlavorMap {
  BerryFlavorMap(potency: Int, flavor: NamedResource)
}

const path = "berry"

/// Fetches a berry by the berry ID.
///
/// # Example
///
/// ```gleam
/// let result = berry.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, berry())
}

/// Fetches a berry by the berry name.
///
/// # Example
///
/// ```gleam
/// let result = berry.fetch_by_name("cheri")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, berry())
}

fn berry() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use growth_time <- decode.parameter
    use max_harvest <- decode.parameter
    use natural_gift_power <- decode.parameter
    use size <- decode.parameter
    use smoothness <- decode.parameter
    use soil_dryness <- decode.parameter
    use firmness <- decode.parameter
    use flavors <- decode.parameter
    use item <- decode.parameter
    use natural_gift_type <- decode.parameter
    Berry(
      id,
      name,
      growth_time,
      max_harvest,
      natural_gift_power,
      size,
      smoothness,
      soil_dryness,
      firmness,
      flavors,
      item,
      natural_gift_type,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("growth_time", decode.int)
  |> decode.field("max_harvest", decode.int)
  |> decode.field("natural_gift_power", decode.int)
  |> decode.field("size", decode.int)
  |> decode.field("smoothness", decode.int)
  |> decode.field("soil_dryness", decode.int)
  |> decode.field("firmness", named_resource())
  |> decode.field("flavors", decode.list(of: berry_flavor_map()))
  |> decode.field("item", named_resource())
  |> decode.field("natural_gift_type", named_resource())
}

fn berry_flavor_map() {
  decode.into({
    use potency <- decode.parameter
    use berry <- decode.parameter
    BerryFlavorMap(potency, berry)
  })
  |> decode.field("potency", decode.int)
  |> decode.field("flavor", named_resource())
}