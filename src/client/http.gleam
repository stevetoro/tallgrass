import decode.{type Decoder}
import gleam/hackney
import gleam/http/request
import gleam/http/response.{type Response}
import gleam/json
import gleam/option.{type Option, None, Some}
import gleam/result

const api_url = "pokeapi.co/api/v2"

pub type Error {
  RequestError
  DecodeError
}

pub fn get(resource resource: Option(String), at path: String) {
  let path = case resource {
    Some(identifier) -> path <> "/" <> identifier
    None -> path
  }

  request.new()
  |> request.set_host(api_url)
  |> request.set_path(path)
  |> request.set_header("Content-Type", "application/json")
  |> hackney.send
  |> result.replace_error(RequestError)
}

pub fn decode(response: Response(String), using decoder: Decoder(t)) {
  response.body
  |> json.decode(using: decode.from(decoder, _))
  |> result.replace_error(DecodeError)
}
