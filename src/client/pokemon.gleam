import api/pokemon.{pokemon}
import client/http.{decode_response, request_with_id, request_with_name}
import gleam/result

pub fn get_by_name(name: String) {
  use response <- result.try(request_with_name("pokemon", name))
  response
  |> decode_response(using: pokemon())
}

pub fn get_by_id(id: Int) {
  use response <- result.try(request_with_id("pokemon", id))
  response
  |> decode_response(using: pokemon())
}
