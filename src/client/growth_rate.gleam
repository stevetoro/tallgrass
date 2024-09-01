import internal/pokemon/growth_rate/client

/// Fetches a pokemon growth rate by the growth rate ID.
///
/// # Example
///
/// ```gleam
/// let result = growth_rate.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a pokemon growth rate by the growth rate name.
///
/// # Example
///
/// ```gleam
/// let result = growth_rate.fetch_by_name("slow")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
