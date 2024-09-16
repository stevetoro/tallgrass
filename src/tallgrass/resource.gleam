import decode.{type Decoder}
import gleam/hackney
import gleam/http/request
import gleam/http/response.{type Response}
import gleam/int.{to_string}
import gleam/json
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string

const api_url = "pokeapi.co/api/v2"

pub type Error {
  RequestError
  DecodeError
}

pub type Resource {
  Resource(url: String)
}

@internal
pub fn resource() {
  decode.into({
    use url <- decode.parameter
    Resource(url)
  })
  |> decode.field("url", decode.string)
}

pub type NamedResource {
  NamedResource(name: String, url: String)
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

pub fn fetch_by_id(id: Int, path: String, decoder: Decoder(a)) {
  use response <- result.try(get(resource: Some(id |> to_string), at: path))
  decode(response, using: decoder)
}

pub fn fetch_by_name(name: String, path: String, decoder: Decoder(a)) {
  use response <- result.try(get(resource: Some(name), at: path))
  decode(response, using: decoder)
}

fn get(resource resource: Option(String), at path: String) {
  let split_path = path |> string.split(on: ",")

  // TODO: super hacky but didn't want to write another get function
  // since location_area is the only nested resource in pokeapi.
  let path = case resource, split_path {
    Some(r), [p, ..rest] -> [p, r, ..rest] |> string.join(with: "/")
    Some(r), _ -> path <> "/" <> r
    None, _ -> split_path |> string.join(with: "/")
  }

  request.new()
  |> request.set_host(api_url)
  |> request.set_path(path)
  |> request.set_header("Content-Type", "application/json")
  |> hackney.send
  |> result.replace_error(RequestError)
}

fn decode(response: Response(String), using decoder: Decoder(t)) {
  response.body
  |> json.decode(using: decode.from(decoder, _))
  |> result.replace_error(DecodeError)
}
