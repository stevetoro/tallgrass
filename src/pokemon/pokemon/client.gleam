import gleam/int.{to_string}
import gleam/option.{None, Some}
import gleam/result
import http/request.{get}
import http/response.{decode}
import pokemon/pokemon/pokemon.{pokemon}

const path = "pokemon"

pub fn fetch() {
  use response <- result.try(get(resource: None, at: path))
  decode(response, using: pokemon())
}

pub fn fetch_by_name(name: String) {
  use response <- result.try(get(resource: Some(name), at: path))
  decode(response, using: pokemon())
}

pub fn fetch_by_id(id: Int) {
  use response <- result.try(get(resource: Some(id |> to_string), at: path))
  decode(response, using: pokemon())
}
