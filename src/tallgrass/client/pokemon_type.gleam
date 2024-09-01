import tallgrass/internal/pokemon/pokemon_type/client

/// Fetches a pokemon type by the pokemon type ID.
///
/// # Example
///
/// ```gleam
/// let result = pokemon_type.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a pokemon type by the pokemon type name.
///
/// # Example
///
/// ```gleam
/// let result = pokemon_type.fetch_by_name("fairy")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
