import pokegleam/pokemon/color/client

/// Fetches a pokemon color by the color ID.
///
/// # Example
///
/// ```gleam
/// let result = color.fetch_by_id(9)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a pokemon color by the color name.
///
/// # Example
///
/// ```gleam
/// let result = color.fetch_by_name("white")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
