import gleam/erlang/process
import web

pub fn main() {
  web.start()
  process.sleep_forever()
}
