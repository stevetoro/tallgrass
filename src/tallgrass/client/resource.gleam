//// Building blocks for interacting with PokeAPI resources.

import decode.{type Decoder}
import gleam/int.{to_string}
import gleam/option.{type Option, None, Some}
import gleam/string
import tallgrass/client.{type Client, cache, pagination}
import tallgrass/client/pagination.{
  type PaginationOptions, Default, Limit, Offset, Paginate,
}
import tallgrass/client/request

/// The type of response returned by paginated endpoints. `count` is the total number of records for that type of resource, `results` is a list of
/// fetcheable resources on the current page, and the `next` and `previous` links can be used to traverse the rest of the pages.
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
/// use res <- result.try(pokemon.fetch(DefaultPagination, None))
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
/// pokemon.fetch_resource(resource, None)
/// ```
pub type Resource {
  Resource(url: String)
  NamedResource(url: String, name: String)
}

/// Follows the `next` link of a given `ResourceList` and returns an error if the `next` link is `null`.
///
/// # Example
///
/// ```gleam
/// let client = client.new()
/// use res <- result.try(client |> pokemon.fetch())
/// client |> resource.next(res)
/// ```
pub fn next(client: Client, page: ResourceList) {
  request.next(page.next, resource_list(), client |> cache)
}

/// Follows the `previous` link of a given `ResourceList` and returns an error if the `previous` link is `null`.
///
/// # Example
///
/// ```gleam
/// let client = client.new()
/// use res <- result.try(client |> pokemon.fetch())
/// client |> resource.previous(res)
/// ```
pub fn previous(client: Client, page: ResourceList) {
  request.previous(page.previous, resource_list(), client |> cache)
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
    resource_list(),
    client |> cache,
  )
}

@internal
pub fn fetch_resource(client: Client, resource: Resource, decoder: Decoder(t)) {
  request.get_url(resource.url, decoder, client |> cache)
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
