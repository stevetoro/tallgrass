import decode.{type Decoder}
import gleam/http/response.{type Response}
import gleam/json
import gleam/result
import tallgrass/internal/http/error.{DecodeError}

pub fn decode(response: Response(String), using decoder: Decoder(t)) {
  response.body
  |> json.decode(using: decode.from(decoder, _))
  |> result.replace_error(DecodeError)
}
