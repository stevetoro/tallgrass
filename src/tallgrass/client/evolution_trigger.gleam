import tallgrass/internal/evolution/evolution_trigger/client

/// Fetches an evolution trigger by ID.
///
/// # Example
///
/// ```gleam
/// let result = evolution_trigger.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches an evolution trigger by name.
///
/// # Example
///
/// ```gleam
/// let result = evolution_trigger.fetch_by_name("level-up")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
