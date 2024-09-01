import gleam/int.{to_string}
import gleam/option.{Some}
import gleam/result
import internal/http/request.{get}
import internal/http/response.{decode}
import internal/pokemon/form/form.{form}

const path = "pokemon-form"

pub fn fetch_by_id(id: Int) {
  use response <- result.try(get(resource: Some(id |> to_string), at: path))
  decode(response, using: form())
}

pub fn fetch_by_name(name: String) {
  use response <- result.try(get(resource: Some(name), at: path))
  decode(response, using: form())
}
