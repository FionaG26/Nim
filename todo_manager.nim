import task, strutils, os, times, algorithm

var tasks*: seq[Task] = @[]

# ANSI colors
const
  GREEN = "\e[32m"
  YELLOW = "\e[33m"
  RED = "\e[31m"
  RESET = "\e[0m"

proc addTask*(desc: string, priority: int, deadline: DateTime) =
  let task = Task(
    description: desc,
    priority: priority,
    completed: false,
    createdAt: now(),
    deadline: deadline
  )
  tasks.add(task)
  echo GREEN, "Task added: ", desc, RESET

# Sort by priority (higher first)
proc sortTasks*() =
  tasks.sort(proc(a, b: Task): int = cmp(b.priority, a.priority))

proc listTasks*() =
  if tasks.len == 0:
    echo YELLOW, "No tasks available.", RESET
  else:
    sortTasks()
    for i, task in tasks:
      let status = if task.completed: "[✔]" else: "[ ]"

      let color =
        if task.completed: GREEN
        elif task.deadline < now(): RED
        else: YELLOW

      echo color, i, ": ", status, " ",
           task.description,
           " (Priority: ", task.priority, ")",
           " Due: ", task.deadline.format("yyyy-MM-dd"),
           RESET

proc completeTask*(index: int) =
  if index < 0 or index >= tasks.len:
    echo RED, "Invalid task number.", RESET
  else:
    tasks[index].completed = true
    echo GREEN, "Task marked as completed.", RESET

proc removeTask*(index: int) =
  if index < 0 or index >= tasks.len:
    echo RED, "Invalid task number.", RESET
  else:
    tasks.delete(index)
    echo GREEN, "Task removed.", RESET

# Save tasks
proc saveTasks*(filename: string) =
  var lines: seq[string] = @[]
  for task in tasks:
    let line = task.description & "|" &
               $task.priority & "|" &
               $task.completed & "|" &
               $task.createdAt.toUnix & "|" &
               $task.deadline.toUnix
    lines.add(line)
  writeFile(filename, lines.join("\n"))

# Load tasks
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
        createdAt: fromUnix(parseInt(parts[3])),
        deadline: fromUnix(parseInt(parts[4]))
      )
      tasks.add(t)
