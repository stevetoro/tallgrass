import gleam/int.{to_string}
import gleam/option.{Some}
import gleam/result
import tallgrass/internal/http/request.{get}
import tallgrass/internal/http/response.{decode}
import tallgrass/internal/item/pocket/pocket.{item_pocket}

const path = "item-pocket"

pub fn fetch_by_name(name: String) {
  use response <- result.try(get(resource: Some(name), at: path))
  decode(response, using: item_pocket())
}

pub fn fetch_by_id(id: Int) {
  use response <- result.try(get(resource: Some(id |> to_string), at: path))
  decode(response, using: item_pocket())
}
