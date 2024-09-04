import tallgrass/internal/encounter/encounter_method/client

/// Fetches an encounter method by the method ID.
///
/// # Example
///
/// ```gleam
/// let result = encounter_method.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches an encounter method by the method name.
///
/// # Example
///
/// ```gleam
/// let result = encounter_method.fetch_by_name("walk")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
