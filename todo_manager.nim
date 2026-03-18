import task, os, times, algorithm, strutils

var tasks*: seq[Task] = @[]

# Add task
proc addTask*(desc: string, priority: int, deadline: DateTime) =
  let task = Task(
    description: desc,
    priority: priority,
    completed: false,
    createdAt: now(),
    deadline: deadline
  )
  tasks.add(task)

# Complete task
proc completeTask*(index: int) =
  if index >= 0 and index < tasks.len:
    tasks[index].completed = true

# Remove task
proc removeTask*(index: int) =
  if index >= 0 and index < tasks.len:
    tasks.delete(index)

# Sort by priority
proc sortTasks*() =
  tasks.sort(proc(a, b: Task): int = cmp(b.priority, a.priority))

# List tasks
proc listTasks*() =
  sortTasks()
  for i, t in tasks:
    let status = if t.completed: "[✔]" else: "[ ]"
    echo i, ": ", status, " ", t.description,
         " (Priority: ", t.priority, ") Due: ", t.deadline.format("yyyy-MM-dd")

# Save tasks to file
proc saveTasks*(filename: string) =
  var lines: seq[string] = @[]
  for task in tasks:
    let line = task.description & "|" &
               $task.priority & "|" &
               $task.completed & "|" &
               $task.createdAt.epochTime & "|" &
               $task.deadline.epochTime
    lines.add(line)
  writeFile(filename, lines.join("\n"))

# Load tasks from file
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
        createdAt: fromTime(parseInt(parts[3])),
        deadline: fromTime(parseInt(parts[4]))
      )
      tasks.add(t)
