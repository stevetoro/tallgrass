import tallgrass/internal/location/pal_park_area/client

/// Fetches a pal_park_area by the pal_park_area ID.
///
/// # Example
///
/// ```gleam
/// let result = pal_park_area.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a pal_park_area by the pal_park_area name.
///
/// # Example
///
/// ```gleam
/// let result = pal_park_area.fetch_by_name("forest")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
