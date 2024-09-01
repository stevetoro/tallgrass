import tallgrass/internal/pokemon/nature/client

/// Fetches a pokemon nature by the nature ID.
///
/// # Example
///
/// ```gleam
/// let result = nature.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a pokemon nature by the nature name.
///
/// # Example
///
/// ```gleam
/// let result = nature.fetch_by_name("hardy")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
