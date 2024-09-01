import tallgrass/internal/pokemon/ability/client

/// Fetches a pokemon ability by the ability ID.
///
/// # Example
///
/// ```gleam
/// let result = ability.fetch_by_id(32)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a pokemon ability by the ability name.
///
/// # Example
///
/// ```gleam
/// let result = ability.fetch_by_name("serene-grace")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
