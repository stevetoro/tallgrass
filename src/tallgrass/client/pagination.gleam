/// Paginated endpoints accept `limit` and `offset` query parameters.
///
/// # Example
///
/// ```gleam
/// let client = pokemon.new()
///
/// // Sets the limit to 100
/// client |> with_pagination(Limit(100)) |> pokemon.fetch()
///
/// // Sets the offset to 20
/// client |> with_pagination(Offset(20)) |> pokemon.fetch()
///
/// // Sets the limit to 100 and the offset to 20
/// client |> with_pagination(Paginate(100, 20)) |> pokemon.fetch()
/// ```
pub type PaginationOptions {
  Default
  Limit(Int)
  Offset(Int)
  Paginate(limit: Int, offset: Int)
}
