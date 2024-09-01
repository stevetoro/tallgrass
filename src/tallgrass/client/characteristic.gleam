import tallgrass/internal/pokemon/characteristic/client

/// Fetches a pokemon characteristic by the characteristic ID.
///
/// # Example
///
/// ```gleam
/// let result = characteristic.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}
