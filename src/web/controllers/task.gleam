import gleam/json.{array, bool, object, string}
import web/controller.{json_response}

type Task {
  Task(completed: Bool, description: String, id: String)
}

pub fn index() {
  get_tasks()
  |> json_response(tasks_encoder)
}

fn get_tasks() {
  [
    Task(
      completed: False,
      description: "Wrap up this POC.",
      id: "103084962a734f80831d940fd3ab60d4",
    ),
    Task(
      completed: True,
      description: "Brew the morning coffee",
      id: "103084962a734f80831d940fd3ab60d4",
    ),
  ]
}

fn tasks_encoder(tasks: List(Task)) {
  array(tasks, task_encoder)
}

fn task_encoder(task: Task) {
  object([
    #("completed", bool(task.completed)),
    #("description", string(task.description)),
    #("id", string(task.id)),
  ])
}
