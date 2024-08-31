import api/pokeathlon_stat.{pokeathlon_stat}
import client/http.{decode, get}
import gleam/int.{to_string}
import gleam/option.{None, Some}
import gleam/result

const path = "pokeathlon-stat"

pub fn fetch() {
  use response <- result.try(get(resource: None, at: path))
  decode(response, using: pokeathlon_stat())
}

pub fn fetch_by_id(id: Int) {
  use response <- result.try(get(resource: Some(id |> to_string), at: path))
  decode(response, using: pokeathlon_stat())
}

pub fn fetch_by_name(name: String) {
  use response <- result.try(get(resource: Some(name), at: path))
  decode(response, using: pokeathlon_stat())
}
