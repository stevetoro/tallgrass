import decode.{type Decoder}
import gleam/int.{to_string}
import gleam/option.{type Option, None, Some}
import gleam/string
import tallgrass/request.{type PaginationOptions}

pub fn fetch_by_id(id: Int, path: String, using decoder: Decoder(a)) {
  let path = path_from(Some(id |> to_string), path)
  request.get(path, None, decoder: decoder)
}

pub fn fetch_by_name(name: String, path: String, using decoder: Decoder(a)) {
  let path = path_from(Some(name), path)
  request.get(path, None, decoder: decoder)
}

// TODO:
// it would be really nice to simplify API resources using union types,
// but only if it's not at the expense of the consumer. i.e. having to make
// additional pattern matches just to get the "optional" name of a resource.

pub type NamedResourceList {
  NamedResourceList(
    count: Int,
    next: Option(String),
    previous: Option(String),
    results: List(NamedResource),
  )
}

pub type NamedResource {
  NamedResource(name: String, url: String)
}

pub fn fetch_named_resources(path: String, options: Option(PaginationOptions)) {
  request.get(path, options, decoder: named_resource_list())
}

pub fn fetch_named_resource(resource: NamedResource, using decoder: Decoder(a)) {
  request.get_url(resource.url, decoder: decoder)
}

pub fn next_named_resource_page(page: NamedResourceList) {
  request.next(page.next, decoder: named_resource_list())
}

pub fn previous_named_resource_page(page: NamedResourceList) {
  request.previous(page.previous, decoder: named_resource_list())
}

pub type ResourceList {
  ResourceList(
    count: Int,
    next: Option(String),
    previous: Option(String),
    results: List(Resource),
  )
}

pub type Resource {
  Resource(url: String)
}

pub fn fetch_resources(path: String, options: Option(PaginationOptions)) {
  request.get(path, options, decoder: resource_list())
}

pub fn fetch_resource(resource: Resource, using decoder: Decoder(a)) {
  request.get_url(resource.url, decoder: decoder)
}

pub fn next_resource_page(page: ResourceList) {
  request.next(page.next, decoder: resource_list())
}

pub fn previous_resource_page(page: ResourceList) {
  request.previous(page.previous, decoder: resource_list())
}

@internal
pub fn named_resource_list() {
  decode.into({
    use count <- decode.parameter
    use next <- decode.parameter
    use previous <- decode.parameter
    use results <- decode.parameter
    NamedResourceList(count, next, previous, results)
  })
  |> decode.field("count", decode.int)
  |> decode.field("next", decode.optional(decode.string))
  |> decode.field("previous", decode.optional(decode.string))
  |> decode.field("results", decode.list(of: named_resource()))
}

@internal
pub fn named_resource() {
  decode.into({
    use name <- decode.parameter
    use url <- decode.parameter
    NamedResource(name, url)
  })
  |> decode.field("name", decode.string)
  |> decode.field("url", decode.string)
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
  decode.into({
    use url <- decode.parameter
    Resource(url)
  })
  |> decode.field("url", decode.string)
}

fn path_from(resource: Option(String), path: String) {
  let split_path = path |> string.split(on: ",")
  case resource, split_path {
    Some(r), [p, ..rest] -> [p, r, ..rest] |> string.join(with: "/")
    Some(r), _ -> path <> "/" <> r
    None, _ -> split_path |> string.join(with: "/")
  }
}
