import gleam/int.{to_string}
import gleam/option.{None, Some}
import gleam/result
import http/request.{get}
import http/response.{decode}
import pokemon/form/form.{form}

const path = "pokemon-form"

pub fn fetch() {
  use response <- result.try(get(resource: None, at: path))
  decode(response, using: form())
}

pub fn fetch_by_id(id: Int) {
  use response <- result.try(get(resource: Some(id |> to_string), at: path))
  decode(response, using: form())
}

pub fn fetch_by_name(name: String) {
  use response <- result.try(get(resource: Some(name), at: path))
  decode(response, using: form())
}
