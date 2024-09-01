import tallgrass/internal/pokemon/egg_group/client

/// Fetches a pokemon egg group by the egg group ID.
///
/// # Example
///
/// ```gleam
/// let result = egg_group.fetch_by_id(13)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a pokemon egg group by the egg group name.
///
/// # Example
///
/// ```gleam
/// let result = egg_group.fetch_by_name("ditto")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
