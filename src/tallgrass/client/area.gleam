import tallgrass/internal/location/area/client

/// Fetches a location_area by the location_area ID.
///
/// # Example
///
/// ```gleam
/// let result = area.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a location_area by the location_area name.
///
/// # Example
///
/// ```gleam
/// let result = area.fetch_by_name("canalave-city-area")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
