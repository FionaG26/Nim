import task, strutils, os

var tasks*: seq[Task] = @[]

proc addTask*(desc: string, priority: int) =
  let task = Task(description: desc, priority: priority, completed: false)
  tasks.add(task)
  echo "Task added: ", desc

proc listTasks*() =
  if tasks.len == 0:
    echo "No tasks available."
  else:
    for i, task in tasks:
      let status = if task.completed: "[✔]" else: "[ ]"
      echo i, ": ", status, " ", task.description, " (Priority: ", task.priority, ")"

proc completeTask*(index: int) =
  if index < 0 or index >= tasks.len:
    echo "Invalid task number."
  else:
    tasks[index].completed = true
    echo "Task marked as completed."

proc removeTask*(index: int) =
  if index < 0 or index >= tasks.len:
    echo "Invalid task number."
  else:
    tasks.delete(index)
    echo "Task removed."

# Save tasks to file
proc saveTasks*(filename: string) =
  var lines: seq[string] = @[]
  for task in tasks:
    let line = task.description & "|" & $task.priority & "|" & $task.completed
    lines.add(line)
  writeFile(filename, lines.join("\n"))
  echo "Tasks saved."

# Load tasks from file
proc loadTasks*(filename: string) =
  if not fileExists(filename):
    return

  let content = readFile(filename)
  for line in content.splitLines():
    if line.len == 0: continue
    let parts = line.split("|")
    if parts.len == 3:
      let t = Task(
        description: parts[0],
        priority: parseInt(parts[1]),
        completed: parseBool(parts[2])
      )
      tasks.add(t)
