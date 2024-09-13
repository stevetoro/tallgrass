import tallgrass/internal/item/item/client

/// Fetches a item by the item ID.
///
/// # Example
///
/// ```gleam
/// let result = item.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a item by the item name.
///
/// # Example
///
/// ```gleam
/// let result = item.fetch_by_name("master-ball")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
