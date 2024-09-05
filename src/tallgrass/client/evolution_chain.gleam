import tallgrass/internal/evolution/evolution_chain/client

/// Fetches an evolution chain by ID.
///
/// # Example
///
/// ```gleam
/// let result = evolution_chain.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}
