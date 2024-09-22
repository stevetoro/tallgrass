//// Building blocks for interacting with PokeAPI resources.

import decode.{type Decoder}
import gleam/int.{to_string}
import gleam/option.{type Option, None, Some}
import gleam/string
import tallgrass/cache.{type Cache}
import tallgrass/request

/// The type of response returned by paginated endpoints. `count` is the total number of records for that resource, `results` are a list of
/// fetcheable `Resource` on the current page, and the `next` and `previous` links can be used to traverse the rest of the pages.
pub type ResourceList {
  ResourceList(
    count: Int,
    next: Option(String),
    previous: Option(String),
    results: List(Resource),
  )
}

/// The majority of PokeAPI resources are of type `NamedResource`, however there are a few of type `Resource` that are composed only of a URL.
/// Because both variants include a URL, fetching the full resource is simply a matter of passing it to a `fetch_resource` function.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(pokemon.fetch(DefaultPagination, NoCache))
/// let assert Ok(resource) = res.results |> list.first
///
/// // most resources will take this shape
/// let assert NamedResource(url, name) = resource
///
/// // matching on both variants is safer
/// case resource {
///   NamedResource(url, name) -> {todo} // do something with name
///   Resource(url) -> {todo} // do something with url
/// }
///
/// // fetch the full resource to get more than just the name and url
/// pokemon.fetch_resource(resource, NoCache)
/// ```
pub type Resource {
  Resource(url: String)
  NamedResource(url: String, name: String)
}

/// Paginated endpoints accept `limit` and `offset` query parameters.
/// If `DefaultPagination` is used, PokeAPI will use a limit of 20 and an offset of 0.
///
/// # Example
///
/// ```gleam
/// // Sets the limit to 100
/// pokemon.fetch(Limit(100), NoCache)
///
/// // Sets the offset to 20
/// pokemon.fetch(Offset(20), NoCache)
///
/// // Sets the limit to 100 and the offset to 20
/// pokemon.fetch(Paginate(limit: 100, offset: 20), NoCache)
/// ```
pub type PaginationOptions {
  Paginate(limit: Int, offset: Int)
  Limit(Int)
  Offset(Int)
  DefaultPagination
}

/// Follows the `next` link of a given `ResourceList` and returns an error if the `next` link is `null`.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(pokemon.fetch(DefaultPagination, NoCache))
/// res |> resource.next(NoCache)
/// ```
pub fn next(page: ResourceList, cache: Cache) {
  request.next(page.next, resource_list(), cache)
}

/// Follows the `previous` link of a given `ResourceList` and returns an error if the `previous` link is `null`.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(pokemon.fetch(Offset(100), NoCache))
/// res |> resource.previous(NoCache)
/// ```
pub fn previous(page: ResourceList, cache: Cache) {
  request.previous(page.previous, resource_list(), cache)
}

@internal
pub fn fetch_by_id(id: Int, path: String, decoder: Decoder(t), cache: Cache) {
  let path = path_from(Some(id |> to_string), path)
  request.get(path, [], decoder, cache)
}

@internal
pub fn fetch_by_name(
  name: String,
  path: String,
  decoder: Decoder(t),
  cache: Cache,
) {
  let path = path_from(Some(name), path)
  request.get(path, [], decoder, cache)
}

@internal
pub fn fetch_resources(path: String, options: PaginationOptions, cache: Cache) {
  request.get(path, options |> query, resource_list(), cache)
}

@internal
pub fn fetch_resource(resource: Resource, decoder: Decoder(t), cache: Cache) {
  request.get_url(resource.url, decoder, cache)
}

@internal
pub fn resource_list() {
  decode.into({
    use count <- decode.parameter
    use next <- decode.parameter
    use previous <- decode.parameter
    use results <- decode.parameter
    ResourceList(count, next, previous, results)
  })
  |> decode.field("count", decode.int)
  |> decode.field("next", decode.optional(decode.string))
  |> decode.field("previous", decode.optional(decode.string))
  |> decode.field("results", decode.list(of: resource()))
}

@internal
pub fn resource() {
  decode.one_of([
    decode.into({
      use name <- decode.parameter
      use url <- decode.parameter
      NamedResource(url, name)
    })
      |> decode.field("name", decode.string)
      |> decode.field("url", decode.string),
    decode.into({
      use url <- decode.parameter
      Resource(url)
    })
      |> decode.field("url", decode.string),
  ])
}

fn path_from(resource: Option(String), path: String) {
  let split_path = path |> string.split(on: ",")
  case resource, split_path {
    Some(r), [p, ..rest] -> [p, r, ..rest] |> string.join(with: "/")
    Some(r), _ -> path <> "/" <> r
    None, _ -> split_path |> string.join(with: "/")
  }
}

fn query(options: PaginationOptions) {
  case options {
    Paginate(limit, offset) -> [
      #("limit", limit |> to_string),
      #("offset", offset |> to_string),
    ]
    Limit(limit) -> [#("limit", limit |> to_string)]
    Offset(offset) -> [#("offset", offset |> to_string)]
    DefaultPagination -> []
  }
}
