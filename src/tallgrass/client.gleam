import tallgrass/client/cache.{type Cache, NoCache}
import tallgrass/client/pagination.{type PaginationOptions, Default}

pub opaque type Client {
  Client(cache: Cache, pagination: PaginationOptions)
}

pub fn new() {
  Client(cache: NoCache, pagination: Default)
}

pub fn cache(client: Client) {
  client.cache
}

pub fn pagination(client: Client) {
  client.pagination
}

pub fn with_cache(client: Client, cache: Cache) {
  Client(..client, cache: cache)
}

pub fn with_pagination(client: Client, pagination: PaginationOptions) {
  Client(..client, pagination: pagination)
}
