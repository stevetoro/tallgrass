import tallgrass/internal/encounter/encounter_condition/client

/// Fetches an encounter condition by the condition ID.
///
/// # Example
///
/// ```gleam
/// let result = encounter_condition.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches an encounter condition by the condition name.
///
/// # Example
///
/// ```gleam
/// let result = encounter_condition.fetch_by_name("swarm")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
