import tallgrass/internal/encounter/encounter_condition_value/client

/// Fetches an encounter condition value by ID.
///
/// # Example
///
/// ```gleam
/// let result = encounter_condition_value.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches an encounter condition value by name.
///
/// # Example
///
/// ```gleam
/// let result = encounter_condition_value.fetch_by_name("swarm-yes")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
