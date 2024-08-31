import gleam/int.{to_string}
import gleam/option.{None, Some}
import gleam/result
import http/request.{get}
import http/response.{decode}
import pokemon/egg_group/egg_group.{egg_group}

const path = "egg-group"

pub fn fetch() {
  use response <- result.try(get(resource: None, at: path))
  decode(response, using: egg_group())
}

pub fn fetch_by_id(id: Int) {
  use response <- result.try(get(resource: Some(id |> to_string), at: path))
  decode(response, using: egg_group())
}

pub fn fetch_by_name(name: String) {
  use response <- result.try(get(resource: Some(name), at: path))
  decode(response, using: egg_group())
}
