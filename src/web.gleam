import gleam/bit_builder
import gleam/http/response
import gleam/io
import mist
import web/router
import web/static

pub fn start() {
  let assert Ok(_) = mist.run_service(3000, handle_request, 4_000_000)

  io.println("Started listening on http://localhost:3000 ✨")
}

fn handle_request(request) {
  use <- router.handle_request(request)
  use <- static.handle_request(request)

  response.new(404)
  |> response.set_header("content-type", "text/plain")
  |> response.set_body(bit_builder.from_string("Not found"))
}
