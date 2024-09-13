import tallgrass/internal/item/category/client

/// Fetches an item_category by the item_category ID.
///
/// # Example
///
/// ```gleam
/// let result = item_category.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches an item_category by the item_category name.
///
/// # Example
///
/// ```gleam
/// let result = item_category.fetch_by_name("stat-boosts")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
