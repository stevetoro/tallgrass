import internal/pokemon/stat/client

/// Fetches a pokemon stat by the stat ID.
///
/// # Example
///
/// ```gleam
/// let result = stat.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a pokemon stat by the stat name.
///
/// # Example
///
/// ```gleam
/// let result = stat.fetch_by_name("hp")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
