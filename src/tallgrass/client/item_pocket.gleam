import tallgrass/internal/item/pocket/client

/// Fetches an item_pocket by the item_pocket ID.
///
/// # Example
///
/// ```gleam
/// let result = item_pocket.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches an item_pocket by the item_pocket name.
///
/// # Example
///
/// ```gleam
/// let result = item_pocket.fetch_by_name("misc")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
