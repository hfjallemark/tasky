import gleam/http/request.{Request}
import web/controllers/task

pub fn handle_request(request: Request(BitString), continue) {
  case request.path {
    "/api/tasks" -> task.index()
    _ -> continue()
  }
}
