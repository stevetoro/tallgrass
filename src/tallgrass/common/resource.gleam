import decode
import gleam/option.{type Option}

/// The type of response returned by paginated endpoints. `count` is the total number of records for that type of resource, `results` is a list of
/// fetcheable resources on the current page, and the `next` and `previous` links can be used to traverse the rest of the pages.
pub type ResourcePage {
  ResourcePage(
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

@internal
pub fn resource_page() {
  decode.into({
    use count <- decode.parameter
    use next <- decode.parameter
    use previous <- decode.parameter
    use results <- decode.parameter
    ResourcePage(count, next, previous, results)
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
