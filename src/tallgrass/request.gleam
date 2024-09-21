import decode.{type Decoder}
import gleam/hackney
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/json
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string.{split}

const host = "pokeapi.co/api/v2"

const api_url = "https://" <> host <> "/"

pub type Error {
  RequestError
  DecodeError
  NoPreviousPage
  NoNextPage
}

pub type QueryParams =
  List(#(String, String))

pub fn next(url: Option(String), decoder decoder: Decoder(t)) {
  case url {
    Some(url) -> get_url(url, decoder)
    None -> Error(NoNextPage)
  }
}

pub fn previous(url: Option(String), decoder decoder: Decoder(t)) {
  case url {
    Some(url) -> get_url(url, decoder)
    None -> Error(NoPreviousPage)
  }
}

pub fn get_url(url: String, decoder decoder: Decoder(t)) {
  let assert [_, path] = url |> split(on: api_url)
  get(path, [], decoder)
}

pub fn get(path: String, query: QueryParams, decoder decoder: Decoder(t)) {
  use response <- result.try(
    new()
    |> request.set_path(path)
    |> request.set_query(query)
    |> send,
  )
  response |> decode(using: decoder)
}

fn new() {
  request.new()
  |> request.set_host(host)
  |> request.set_header("Content-Type", "application/json")
}

fn send(request: Request(String)) {
  request
  |> hackney.send
  |> result.replace_error(RequestError)
}

fn decode(response: Response(String), using decoder: Decoder(t)) {
  response.body
  |> json.decode(using: decode.from(decoder, _))
  |> result.replace_error(DecodeError)
}
