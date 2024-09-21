import decode.{type Decoder}
import gleam/int.{to_string}
import gleam/option.{type Option, None, Some}
import gleam/string
import tallgrass/request.{type PaginationOptions}

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
  NamedResource(url: String, name: String)
}

pub fn fetch_by_id(id: Int, path: String, using decoder: Decoder(t)) {
  let path = path_from(Some(id |> to_string), path)
  request.get(path, None, decoder: decoder)
}

pub fn fetch_by_name(name: String, path: String, using decoder: Decoder(t)) {
  let path = path_from(Some(name), path)
  request.get(path, None, decoder: decoder)
}

pub fn fetch_resources(path: String, options: Option(PaginationOptions)) {
  request.get(path, options, decoder: resource_list())
}

pub fn fetch_resource(resource: Resource, using decoder: Decoder(t)) {
  request.get_url(resource.url, decoder: decoder)
}

pub fn next(page: ResourceList) {
  request.next(page.next, decoder: resource_list())
}

pub fn previous(page: ResourceList) {
  request.previous(page.previous, decoder: resource_list())
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
