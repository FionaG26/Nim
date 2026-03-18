import times, strutils, os, algorithm
import task

# Global task sequence
var tasks*: seq[Task] = @[]

# Add a new task
proc addTask*(desc: string, priority: int, deadline: Time) =
  let task = Task(
    description: desc,
    priority: priority,
    completed: false,
    createdAt: now(),
    deadline: deadline
  )
  tasks.add(task)

# Mark task as completed
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

# List all tasks
proc listTasks*() =
  sortTasks()
  for i, t in tasks:
    let status = if t.completed: "[✔]" else: "[ ]"
    echo i, ": ", status, " ", t.description,
         " (Priority: ", t.priority, ") Due: ", t.deadline.format("yyyy-MM-dd")

# Save tasks to a file
proc saveTasks*(filename: string) =
  var lines: seq[string] = @[]
  for task in tasks:
    # Use timeToUnix / unixToTime for Nim 2.x
    let line = task.description & "|" &
               $task.priority & "|" &
               $task.completed & "|" &
               $task.createdAt.timeToUnix & "|" &
               $task.deadline.timeToUnix
    lines.add(line)
  writeFile(filename, lines.join("\n"))

# Load tasks from a file
proc loadTasks*(filename: string) =
  if not fileExists(filename):
    return
  let content = readFile(filename)
  for line in content.splitLines():
    if line.len == 0: continue
    let parts = line.split("|")
    if parts.len == 5:
      let t = Task(
        description: parts[0],
        priority: parseInt(parts[1]),
        completed: parseBool(parts[2]),
        createdAt: unixToTime(parseInt(parts[3])),
        deadline: unixToTime(parseInt(parts[4]))
      )
      tasks.add(t)
