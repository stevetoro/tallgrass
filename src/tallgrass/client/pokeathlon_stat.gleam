import tallgrass/internal/pokemon/pokeathlon_stat/client

/// Fetches a pokemon pokeathlon stat by the pokeathlon stat ID.
///
/// # Example
///
/// ```gleam
/// let result = pokeathlon_stat.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a pokemon pokeathlon stat by the pokeathlon stat name.
///
/// # Example
///
/// ```gleam
/// let result = pokeathlon_stat.fetch_by_name("skill")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
