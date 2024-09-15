import decode
import tallgrass/fetch
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}

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
    firmness: Affordance,
    flavors: List(Flavor),
    item: Affordance,
    natural_gift_type: Affordance,
  )
}

pub type Flavor {
  Flavor(potency: Int, flavor: Affordance)
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
  fetch.resource_by_id(id, path, berry())
}

/// Fetches a berry by the berry name.
///
/// # Example
///
/// ```gleam
/// let result = berry.fetch_by_name("cheri")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, berry())
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
  |> decode.field("firmness", affordance())
  |> decode.field("flavors", decode.list(of: flavor()))
  |> decode.field("item", affordance())
  |> decode.field("natural_gift_type", affordance())
}

fn flavor() {
  decode.into({
    use potency <- decode.parameter
    use flavor <- decode.parameter
    Flavor(potency, flavor)
  })
  |> decode.field("potency", decode.int)
  |> decode.field("flavor", affordance())
}
