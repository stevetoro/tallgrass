import tallgrass/internal/game/generation/client

/// Fetches a generation by the generation ID.
///
/// # Example
///
/// ```gleam
/// let result = generation.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a generation by the generation name.
///
/// # Example
///
/// ```gleam
/// let result = generation.fetch_by_name("generation-i")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
