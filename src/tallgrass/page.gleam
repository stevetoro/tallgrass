pub type PaginationOptions {
  Default
  Limit(Int)
  Offset(Int)
  Paginate(limit: Int, offset: Int)
}
