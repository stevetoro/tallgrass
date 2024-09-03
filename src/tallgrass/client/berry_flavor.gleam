import tallgrass/internal/berry/flavor/client

/// Fetches a berry flavor by the flavor ID.
///
/// # Example
///
/// ```gleam
/// let result = berry_flavor.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a berry flavor by the flavor name.
///
/// # Example
///
/// ```gleam
/// let result = berry_flavor.fetch_by_name("spicy")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
