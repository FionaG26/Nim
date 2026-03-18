import times, strutils, os, algorithm
import task

var tasks*: seq[Task] = @[]

# Add a new task
proc addTask*(desc: string, priority: int, deadline: Time) =
  let t = Task(
    description: desc,
    priority: priority,
    completed: false,
    createdAt: now(),
    deadline: deadline
  )
  tasks.add(t)

# Complete a task
proc completeTask*(index: int) =
  if index >= 0 and index < tasks.len:
    tasks[index].completed = true

# Remove a task
proc removeTask*(index: int) =
  if index >= 0 and index < tasks.len:
    tasks.delete(index)

# Sort tasks by priority (highest first)
proc sortTasks*() =
  tasks.sort(proc(a, b: Task): int = cmp(b.priority, a.priority))

# List tasks
proc listTasks*() =
  sortTasks()
  for i, t in tasks:
    let status = if t.completed: "[✔]" else: "[ ]"
    echo i, ": ", status, " ", t.description,
         " (Priority: ", t.priority, ") Due: ", t.deadline.fromTime().format("yyyy-MM-dd")

# Save tasks to file
proc saveTasks*(filename: string) =
  var lines: seq[string] = @[]
  for t in tasks:
    let line = t.description & "|" &
               $t.priority & "|" &
               $t.completed & "|" &
               $t.createdAt & "|" &
               $t.deadline
    lines.add(line)
  writeFile(filename, lines.join("\n"))

# Load tasks from file
proc loadTasks*(filename: string) =
  if not fileExists(filename): return
  let content = readFile(filename)
  for line in content.splitLines():
    if line.len == 0: continue
    let parts = line.split("|")
    if parts.len == 5:
      let t = Task(
        description: parts[0],
        priority: parseInt(parts[1]),
        completed: parseBool(parts[2]),
        createdAt: parseFloat(parts[3]),
        deadline: parseFloat(parts[4])
      )
      tasks.add(t)
