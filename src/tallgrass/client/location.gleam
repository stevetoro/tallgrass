import tallgrass/internal/location/location/client

/// Fetches a location by the location ID.
///
/// # Example
///
/// ```gleam
/// let result = location.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a location by the location name.
///
/// # Example
///
/// ```gleam
/// let result = location.fetch_by_name("canalave-city")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
