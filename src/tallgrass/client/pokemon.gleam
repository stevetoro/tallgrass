import tallgrass/internal/pokemon/pokemon/client

/// Fetches a pokemon by the pokemon ID.
///
/// # Example
///
/// ```gleam
/// let result = pokemon.fetch_by_id(132)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a pokemon by the pokemon name.
///
/// # Example
///
/// ```gleam
/// let result = pokemon.fetch_by_name("ditto")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
