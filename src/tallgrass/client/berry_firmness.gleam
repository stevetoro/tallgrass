import tallgrass/internal/berry/firmness/client

/// Fetches a berry firmness by the firmness ID.
///
/// # Example
///
/// ```gleam
/// let result = berry_firmness.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a berry firmness by the firmness name.
///
/// # Example
///
/// ```gleam
/// let result = berry_firmness.fetch_by_name("very-soft")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
