import tallgrass/internal/game/version/client

/// Fetches a version by the version ID.
///
/// # Example
///
/// ```gleam
/// let result = version.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a version by the version name.
///
/// # Example
///
/// ```gleam
/// let result = version.fetch_by_name("red")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
