import gleam/int.{to_string}
import gleam/option.{Some}
import gleam/result
import tallgrass/internal/contest/contest_effect/contest_effect.{contest_effect}
import tallgrass/internal/http/request.{get}
import tallgrass/internal/http/response.{decode}

const path = "contest-effect"

pub fn fetch_by_id(id: Int) {
  use response <- result.try(get(resource: Some(id |> to_string), at: path))
  decode(response, using: contest_effect())
}
