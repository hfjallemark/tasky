import gleam/bit_builder
import gleam/erlang/file
import gleam/http/request.{Request}
import gleam/http/response
import gleam/list
import gleam/result
import gleam/string
import utils

pub fn handle_request(request: Request(BitString), continue) {
  let file = case string.contains(request.path, ".") {
    False -> "/index.html"
    True -> request.path
  }

  let path = utils.priv_directory() <> "/static" <> file

  case file.read_bits(path) {
    Ok(contents) -> send_file(contents, path)
    Error(_) -> continue()
  }
}

fn send_file(contents, path) {
  response.new(200)
  |> response.set_header("content-type", get_content_type(path))
  |> response.set_body(bit_builder.from_bit_string(contents))
}

fn get_content_type(path) {
  case get_extension(path) {
    "css" -> "text/css"
    "html" -> "text/html"
    "js" -> "application/javascript"
    "png" -> "image/png"
    "svg" -> "image/svg+xml"
  }
}

fn get_extension(path) {
  path
  |> string.split(".")
  |> list.drop(1)
  |> list.last()
  |> result.unwrap("")
}
