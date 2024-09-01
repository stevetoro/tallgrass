import pokegleam/pokemon/location_area/client

/// Fetches location areas for a given pokemon ID.
///
/// # Example
///
/// ```gleam
/// let result = location_area.fetch_for_pokemon_with_id(1)
/// ```
pub fn fetch_for_pokemon_with_id(id: Int) {
  client.fetch_for_pokemon_with_id(id)
}

/// Fetches location areas for a given pokemon name.
///
/// # Example
///
/// ```gleam
/// let result = location_area.fetch_for_pokemon_with_name("bulbasaur")
/// ```
pub fn fetch_for_pokemon_with_name(name: String) {
  client.fetch_for_pokemon_with_name(name)
}
