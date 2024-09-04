import tallgrass/internal/contest/contest_effect/client

/// Fetches a contest effect by the effect ID.
///
/// # Example
///
/// ```gleam
/// let result = contest_effect.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}
