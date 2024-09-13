import tallgrass/internal/item/fling_effect/client

/// Fetches an item_fling_effect by the item_fling_effect ID.
///
/// # Example
///
/// ```gleam
/// let result = item_fling_effect.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches an item_fling_effect by the item_fling_effect name.
///
/// # Example
///
/// ```gleam
/// let result = item_fling_effect.fetch_by_name("badly-poison")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
