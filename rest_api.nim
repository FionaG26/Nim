import jester, json, times, strutils, os
import task, todo_manager

const FILE_NAME = "tasks.txt"
loadTasks(FILE_NAME)

proc taskToJson(t: Task, id: int): JsonNode =
  %*{
    "id": id,
    "description": t.description,
    "priority": t.priority,
    "completed": t.completed,
    "createdAt": t.createdAt.fromTime().format("yyyy-MM-dd"),
    "deadline": t.deadline.fromTime().format("yyyy-MM-dd")
  }*

# GET all tasks
get "/tasks":
  var arr = newJArray()
  for i, t in tasks:
    arr.add(taskToJson(t, i))
  resp arr

# POST new task
post "/tasks":
  let data = parseJson(request.body)
  let desc = data["description"].getStr
  let pr = data["priority"].getInt
  let dt = parse(data["deadline"].getStr, "yyyy-MM-dd")
  let deadline = dt.toTime()
  addTask(desc, pr, deadline)
  saveTasks(FILE_NAME)
  resp Http200, %*{"status":"Task added"}*

# PUT complete task
put "/tasks/:id/complete":
  let id = param("id").parseInt
  if id < 0 or id >= tasks.len:
    resp Http404, %*{"error":"Task not found"}*
  else:
    completeTask(id)
    saveTasks(FILE_NAME)
    resp %*{"status":"Task completed"}*

# DELETE a task
delete "/tasks/:id":
  let id = param("id").parseInt
  if id < 0 or id >= tasks.len:
    resp Http404, %*{"error":"Task not found"}*
  else:
    removeTask(id)
    saveTasks(FILE_NAME)
    resp %*{"status":"Task removed"}*

routes:
  setPort(5000)
  echo "REST API running on http://localhost:5000"
