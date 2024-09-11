import tallgrass/internal/game/version_group/client

/// Fetches a version_group by the version_group ID.
///
/// # Example
///
/// ```gleam
/// let result = version_group.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a version_group by the version_group name.
///
/// # Example
///
/// ```gleam
/// let result = version_group.fetch_by_name("red-blue")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
