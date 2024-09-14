import tallgrass/internal/location/region/client

/// Fetches a region by the region ID.
///
/// # Example
///
/// ```gleam
/// let result = region.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a region by the region name.
///
/// # Example
///
/// ```gleam
/// let result = region.fetch_by_name("kanto")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
