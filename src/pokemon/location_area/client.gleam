import decode
import gleam/int.{to_string}
import gleam/option.{Some}
import gleam/result
import http/request.{get}
import http/response.{decode}
import pokemon/location_area/location_area.{location_area}

const path = "pokemon,encounters"

pub fn fetch_for_pokemon_with_id(id: Int) {
  use response <- result.try(get(resource: Some(id |> to_string), at: path))
  decode(response, using: decode.list(of: location_area()))
}

pub fn fetch_for_pokemon_with_name(name: String) {
  use response <- result.try(get(resource: Some(name), at: path))
  decode(response, using: decode.list(of: location_area()))
}
