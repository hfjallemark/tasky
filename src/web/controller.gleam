import gleam/bit_builder
import gleam/http/response
import gleam/json.{Json}

pub fn json_response(data: a, encoder: fn(a) -> Json) {
  let json =
    data
    |> encoder()
    |> json.to_string()
    |> bit_builder.from_string()

  response.new(200)
  |> response.set_header("content-type", "application/json")
  |> response.set_body(json)
}
