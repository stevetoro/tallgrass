import gleam/int.{to_string}
import gleam/option.{Some}
import gleam/result
import tallgrass/internal/contest/super_contest_effect/super_contest_effect.{
  super_contest_effect,
}
import tallgrass/internal/http/request.{get}
import tallgrass/internal/http/response.{decode}

const path = "super-contest-effect"

pub fn fetch_by_id(id: Int) {
  use response <- result.try(get(resource: Some(id |> to_string), at: path))
  decode(response, using: super_contest_effect())
}
