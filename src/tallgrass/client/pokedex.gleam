import tallgrass/internal/game/pokedex/client

/// Fetches a pokedex by the pokedex ID.
///
/// # Example
///
/// ```gleam
/// let result = pokedex.fetch_by_id(2)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a pokedex by the pokedex name.
///
/// # Example
///
/// ```gleam
/// let result = pokedex.fetch_by_name("kanto")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
