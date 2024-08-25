import gleam/dynamic.{type Decoder}
import gleam/hackney
import gleam/http/request
import gleam/http/response.{type Response}
import gleam/int
import gleam/json
import gleam/result

const pokeapiurl = "pokeapi.co/api/v2/"

pub type Error {
  RequestError
  DecodeError
}

pub fn request(path: String) {
  request.new()
  |> request.set_host(pokeapiurl)
  |> request.set_path(path)
  |> request.set_header("Content-Type", "application/json")
  |> hackney.send
  |> result.replace_error(RequestError)
}

pub fn request_with_name(path, name: String) -> Result(Response(String), Error) {
  request.new()
  |> request.set_host(pokeapiurl)
  |> request.set_path(path <> "/" <> name)
  |> request.set_header("Content-Type", "application/json")
  |> hackney.send
  |> result.replace_error(RequestError)
}

pub fn request_with_id(path, id: Int) {
  request.new()
  |> request.set_host(pokeapiurl)
  |> request.set_path(path <> "/" <> int.to_string(id))
  |> request.set_header("Content-Type", "application/json")
  |> hackney.send
  |> result.replace_error(RequestError)
}

pub fn decode_response(response: Response(String), using decoder: Decoder(a)) {
  response.body
  |> json.decode(using: decoder)
  |> result.replace_error(DecodeError)
}
