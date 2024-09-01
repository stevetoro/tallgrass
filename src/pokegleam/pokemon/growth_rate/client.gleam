import gleam/int.{to_string}
import gleam/option.{Some}
import gleam/result
import pokegleam/http/request.{get}
import pokegleam/http/response.{decode}
import pokegleam/pokemon/growth_rate/growth_rate.{growth_rate}

const path = "growth-rate"

pub fn fetch_by_id(id: Int) {
  use response <- result.try(get(resource: Some(id |> to_string), at: path))
  decode(response, using: growth_rate())
}

pub fn fetch_by_name(name: String) {
  use response <- result.try(get(resource: Some(name), at: path))
  decode(response, using: growth_rate())
}
