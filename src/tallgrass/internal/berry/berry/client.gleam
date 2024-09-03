import gleam/int.{to_string}
import gleam/option.{Some}
import gleam/result
import tallgrass/internal/berry/berry/berry.{berry}
import tallgrass/internal/http/request.{get}
import tallgrass/internal/http/response.{decode}

const path = "berry"

pub fn fetch_by_name(name: String) {
  use response <- result.try(get(resource: Some(name), at: path))
  decode(response, using: berry())
}

pub fn fetch_by_id(id: Int) {
  use response <- result.try(get(resource: Some(id |> to_string), at: path))
  decode(response, using: berry())
}
