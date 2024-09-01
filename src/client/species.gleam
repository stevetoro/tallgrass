import pokegleam/pokemon/species/client

/// Fetches a pokemon species by the species ID.
///
/// # Example
///
/// ```gleam
/// let result = species.fetch_by_id(132)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a pokemon species by the species name.
///
/// # Example
///
/// ```gleam
/// let result = species.fetch_by_name("ditto")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
