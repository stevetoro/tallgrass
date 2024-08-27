import decode
import gleam/hackney
import gleam/http/request
import gleam/http/response.{type Response}
import gleam/int
import gleam/json
import gleam/result

const api_url = "pokeapi.co/api/v2"

pub type Error {
  RequestError
  DecodeError
}

pub fn get_by_path(path: String) {
  request.new()
  |> request.set_host(api_url)
  |> request.set_path(path)
  |> request.set_header("Content-Type", "application/json")
  |> hackney.send
  |> result.replace_error(RequestError)
}

pub fn get_by_path_and_name(path, name: String) {
  request.new()
  |> request.set_host(api_url)
  |> request.set_path(path <> "/" <> name)
  |> request.set_header("Content-Type", "application/json")
  |> hackney.send
  |> result.replace_error(RequestError)
}

pub fn get_by_path_and_id(path, id: Int) {
  request.new()
  |> request.set_host(api_url)
  |> request.set_path(path <> "/" <> int.to_string(id))
  |> request.set_header("Content-Type", "application/json")
  |> hackney.send
  |> result.replace_error(RequestError)
}

pub fn decode(response: Response(String), using decoder: decode.Decoder(a)) {
  response.body
  |> json.decode(using: decode.from(decoder, _))
  |> result.replace_error(DecodeError)
}
