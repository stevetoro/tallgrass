import tallgrass/internal/contest/contest_type/client

/// Fetches a contest type by the type ID.
///
/// # Example
///
/// ```gleam
/// let result = contest_type.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a contest type by the type name.
///
/// # Example
///
/// ```gleam
/// let result = contest_type.fetch_by_name("very-soft")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
