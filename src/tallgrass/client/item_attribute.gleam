import tallgrass/internal/item/attribute/client

/// Fetches an item_attribute by the item_attribute ID.
///
/// # Example
///
/// ```gleam
/// let result = item_attribute.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches an item_attribute by the item_attribute name.
///
/// # Example
///
/// ```gleam
/// let result = item_attribute.fetch_by_name("countable")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
