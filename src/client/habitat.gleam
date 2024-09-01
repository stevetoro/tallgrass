import pokegleam/pokemon/habitat/client

/// Fetches a pokemon habitat by the habitat ID.
///
/// # Example
///
/// ```gleam
/// let result = habitat.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a pokemon habitat by the habitat name.
///
/// # Example
///
/// ```gleam
/// let result = habitat.fetch_by_name("cave")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
