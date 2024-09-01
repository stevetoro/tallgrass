import tallgrass/internal/pokemon/form/client

/// Fetches a pokemon form by the form ID.
///
/// # Example
///
/// ```gleam
/// let result = form.fetch_by_id(10143)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a pokemon form by the form name.
///
/// # Example
///
/// ```gleam
/// let result = form.fetch_by_name("mewtwo-mega-x")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
