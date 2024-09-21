import decode
import tallgrass/common/effect.{type Effect, effect}
import tallgrass/resource.{type Resource, resource}

pub type ItemFlingEffect {
  ItemFlingEffect(
    id: Int,
    name: String,
    effect_entries: List(Effect),
    items: List(Resource),
  )
}

const path = "item-fling-effect"

/// Fetches an item_fling_effect by the item_fling_effect ID.
///
/// # Example
///
/// ```gleam
/// let result = item_fling_effect.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, item_fling_effect())
}

/// Fetches an item_fling_effect by the item_fling_effect name.
///
/// # Example
///
/// ```gleam
/// let result = item_fling_effect.fetch_by_name("badly-poison")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, item_fling_effect())
}

fn item_fling_effect() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use effect_entries <- decode.parameter
    use items <- decode.parameter
    ItemFlingEffect(id, name, effect_entries, items)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("effect_entries", decode.list(of: effect()))
  |> decode.field("items", decode.list(of: resource()))
}
