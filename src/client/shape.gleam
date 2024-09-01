import internal/pokemon/shape/client

/// Fetches a pokemon shape by the shape ID.
///
/// # Example
///
/// ```gleam
/// let result = shape.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}

/// Fetches a pokemon shape by the shape name.
///
/// # Example
///
/// ```gleam
/// let result = shape.fetch_by_name("ball")
/// ```
pub fn fetch_by_name(name: String) {
  client.fetch_by_name(name)
}
