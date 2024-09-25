import decode.{type Decoder}
import gleam/int.{to_string}
import gleam/option.{type Option, None, Some}
import gleam/string
import tallgrass/client/cache.{type Cache, NoCache}
import tallgrass/client/request
import tallgrass/common/resource.{
  type PaginatedResource, type Resource, paginated_resource,
}

/// Client is the basic type used to make requests. Client should be initialized with client.new and provided
/// with the desired cache and pagination options via `with_cache` and `with_pagination`.
pub opaque type Client {
  Client(cache: Cache, pagination: PaginationOptions)
}

/// Initializes a Client with no cache and default pagination settings.
pub fn new() {
  Client(cache: NoCache, pagination: Default)
}

@internal
pub fn cache(client: Client) {
  client.cache
}

@internal
pub fn pagination(client: Client) {
  client.pagination
}

/// Returns a Client with the provided Cache.
pub fn with_cache(client: Client, cache: Cache) {
  Client(..client, cache: cache)
}

/// Returns a Client with the provided pagination options.
pub fn with_pagination(client: Client, pagination: PaginationOptions) {
  Client(..client, pagination: pagination)
}

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

/// Follows the `next` link of a given `PaginatedResource` and returns an error if the `next` link is `null`.
///
/// # Example
///
/// ```gleam
/// let client = client.new()
/// use res <- result.try(client |> pokemon.fetch())
/// client |> client.next(res)
/// ```
pub fn next(client: Client, page: PaginatedResource) {
  request.next(page.next, paginated_resource(), client |> cache)
}

/// Follows the `previous` link of a given `PaginatedResource` and returns an error if the `previous` link is `null`.
///
/// # Example
///
/// ```gleam
/// let client = client.new()
/// use res <- result.try(client |> pokemon.fetch())
/// client |> client.previous(res)
/// ```
pub fn previous(client: Client, page: PaginatedResource) {
  request.previous(page.previous, paginated_resource(), client |> cache)
}

@internal
pub fn fetch_by_id(client: Client, path: String, id: Int, decoder: Decoder(t)) {
  let path = path_from(Some(id |> to_string), path)
  request.get(path, [], decoder, client |> cache)
}

@internal
pub fn fetch_by_name(
  client: Client,
  path: String,
  name: String,
  decoder: Decoder(t),
) {
  let path = path_from(Some(name), path)
  request.get(path, [], decoder, client |> cache)
}

@internal
pub fn fetch_resources(client: Client, path: String) {
  request.get(
    path,
    query(from: client |> pagination),
    paginated_resource(),
    client |> cache,
  )
}

@internal
pub fn fetch_resource(client: Client, resource: Resource, decoder: Decoder(t)) {
  request.get_url(resource.url, decoder, client |> cache)
}

fn path_from(resource: Option(String), path: String) {
  let split_path = path |> string.split(on: ",")
  case resource, split_path {
    Some(r), [p, ..rest] -> [p, r, ..rest] |> string.join(with: "/")
    Some(r), _ -> path <> "/" <> r
    None, _ -> split_path |> string.join(with: "/")
  }
}

fn query(from options: PaginationOptions) {
  case options {
    Default -> []
    Limit(limit) -> [#("limit", limit |> to_string)]
    Offset(offset) -> [#("offset", offset |> to_string)]
    Paginate(limit, offset) -> [
      #("limit", limit |> to_string),
      #("offset", offset |> to_string),
    ]
  }
}
