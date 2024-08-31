import gleam/int.{to_string}
import gleam/option.{Some}
import gleam/result
import http/request.{get}
import http/response.{decode}
import pokemon/pokeathlon_stat/pokeathlon_stat.{pokeathlon_stat}

const path = "pokeathlon-stat"

pub fn fetch_by_id(id: Int) {
  use response <- result.try(get(resource: Some(id |> to_string), at: path))
  decode(response, using: pokeathlon_stat())
}

pub fn fetch_by_name(name: String) {
  use response <- result.try(get(resource: Some(name), at: path))
  decode(response, using: pokeathlon_stat())
}
