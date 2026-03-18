import jester, json, times, strutils
import os, task, todo_manager

const FILE_NAME = "tasks.txt"
loadTasks(FILE_NAME)

# Convert Task to JSON
proc taskToJson(t: Task, id: int): JsonNode =
  %*{
    "id": id,
    "description": t.description,
    "priority": t.priority,
    "completed": t.completed,
    "createdAt": t.createdAt.format("yyyy-MM-dd"),
    "deadline": t.deadline.format("yyyy-MM-dd")
  }*

# List all tasks
get "/tasks":
  var arr = newJArray()
  for i, t in tasks:
    arr.add(taskToJson(t, i))
  resp arr

# Add new task
post "/tasks":
  let data = parseJson(request.body)
  let desc = data["description"].getStr
  let pr = data["priority"].getInt
  let deadline = parse(data["deadline"].getStr, "yyyy-MM-dd")
  addTask(desc, pr, deadline)
  saveTasks(FILE_NAME)
  resp Http200, %*{"status":"Task added"}*

# Complete a task
put "/tasks/:id/complete":
  let id = param("id").parseInt
  if id < 0 or id >= tasks.len:
    resp Http404, %*{"error":"Task not found"}*
  else:
    completeTask(id)
    saveTasks(FILE_NAME)
    resp %*{"status":"Task completed"}*

# Delete a task
delete "/tasks/:id":
  let id = param("id").parseInt
  if id < 0 or id >= tasks.len:
    resp Http404, %*{"error":"Task not found"}*
  else:
    removeTask(id)
    saveTasks(FILE_NAME)
    resp %*{"status":"Task removed"}*

# Start server
routes:
  setPort(5000)
  echo "REST API running on http://localhost:5000"
