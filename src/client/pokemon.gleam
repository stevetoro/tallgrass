import api/pokemon.{pokemon}
import client/http.{decode, get_by_path_and_id, get_by_path_and_name}
import gleam/result

pub fn get_by_name(name: String) {
  use response <- result.try(get_by_path_and_name("pokemon", name))
  response
  |> decode(using: pokemon())
}

pub fn get_by_id(id: Int) {
  use response <- result.try(get_by_path_and_id("pokemon", id))
  response
  |> decode(using: pokemon())
}
