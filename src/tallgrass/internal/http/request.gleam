import gleam/hackney
import gleam/http/request
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string
import tallgrass/internal/http/error.{RequestError}

const api_url = "pokeapi.co/api/v2"

pub fn get(resource resource: Option(String), at path: String) {
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
