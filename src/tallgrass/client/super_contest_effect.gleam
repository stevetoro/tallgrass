import tallgrass/internal/contest/super_contest_effect/client

/// Fetches a super contest effect by the effect ID.
///
/// # Example
///
/// ```gleam
/// let result = super_contest_effect.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  client.fetch_by_id(id)
}
