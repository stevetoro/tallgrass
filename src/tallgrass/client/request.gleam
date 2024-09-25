import decode.{type Decoder}
import gleam/hackney
import gleam/http/request.{type Request, Request}
import gleam/http/response.{type Response}
import gleam/json
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string.{split}
import gleam/uri
import tallgrass/client/cache.{type Cache, Cache, NoCache, insert, lookup}

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

pub fn next(url: Option(String), decoder: Decoder(t), cache: Cache) {
  case url {
    Some(url) -> get_url(url, decoder, cache)
    None -> Error(NoNextPage)
  }
}

pub fn previous(url: Option(String), decoder: Decoder(t), cache: Cache) {
  case url {
    Some(url) -> get_url(url, decoder, cache)
    None -> Error(NoPreviousPage)
  }
}

pub fn get_url(url: String, decoder: Decoder(t), cache: Cache) {
  let assert [_, path] = url |> split(on: api_url)
  get(path, [], decoder, cache)
}

pub fn get(path: String, query: QueryParams, decoder: Decoder(t), cache: Cache) {
  let req = new(path, query)
  case cache {
    Cache(_) -> {
      use res <- result.try(req |> send_and_cache(using: cache))
      decode(res, using: decoder)
    }
    NoCache -> {
      use res <- result.try(req |> send)
      decode(res, using: decoder)
    }
  }
}

fn new(path: String, query: QueryParams) {
  request.new()
  |> request.set_host(host)
  |> request.set_path(path)
  |> request.set_query(query)
  |> request.set_header("Content-Type", "application/json")
}

fn send_and_cache(req: Request(String), using cache: Cache) {
  let req_string =
    req
    |> request.to_uri
    |> uri.to_string

  case cache |> lookup(req_string) {
    Error(_) -> {
      use res <- result.try(req |> send)
      cache |> insert(req_string, res.body)
      Ok(res)
    }
    Ok(res) -> {
      Ok(response.new(200) |> response.set_body(res))
    }
  }
}

fn send(request: Request(String)) {
  request
  |> hackney.send
  |> result.replace_error(RequestError)
}

fn decode(response: Response(String), using decoder: Decoder(t)) {
  response.body
  |> json.decode(decode.from(decoder, _))
  |> result.replace_error(DecodeError)
}
