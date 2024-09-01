import pokegleam/pokemon/gender/client

/// Fetches a pokemon gender by the gender ID.
///
/// # Example
///
/// ```gleam
/// let result = gender.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a pokemon gender by the gender name.
///
/// # Example
///
/// ```gleam
/// let result = gender.fetch_by_name("genderless")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
