import tallgrass/internal/berry/berry/client

/// Fetches a berry by the berry ID.
///
/// # Example
///
/// ```gleam
/// let result = berry.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a berry by the berry name.
///
/// # Example
///
/// ```gleam
/// let result = berry.fetch_by_name("cheri")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
