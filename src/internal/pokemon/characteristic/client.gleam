import gleam/int.{to_string}
import gleam/option.{Some}
import gleam/result
import internal/http/request.{get}
import internal/http/response.{decode}
import internal/pokemon/characteristic/characteristic.{characteristic}

const path = "characteristic"

pub fn fetch_by_id(id: Int) {
  use response <- result.try(get(resource: Some(id |> to_string), at: path))
  decode(response, using: characteristic())
}
