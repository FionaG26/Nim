import nimx, todo_manager, times, strutils

const FILE_NAME = "tasks.txt"
loadTasks(FILE_NAME)

proc refreshList(lst: ListBox) =
  lst.clear()
  sortTasks()
  for i, t in tasks:
    let status = if t.completed: "[✔]" else: "[ ]"
    lst.addItem($i & ": " & status & " " & t.description &
                " (Priority: " & $t.priority & ") Due: " & t.deadline.format("yyyy-MM-dd"))

let window = newWindow("Nim Todo List", 500, 400)
let taskList = newListBox(window, 10, 10, 480, 250)
refreshList(taskList)

let descEntry = newTextBox(window, 10, 270, 200, 25)
let prEntry = newTextBox(window, 220, 270, 50, 25)
let dlEntry = newTextBox(window, 280, 270, 100, 25)

let addBtn = newButton(window, "Add Task", 390, 270, 100, 25)
addBtn.onClick = proc() =
  try:
    let desc = descEntry.text
    let pr = parseInt(prEntry.text)
    let deadline = parse(dlEntry.text, "yyyy-MM-dd")
    addTask(desc, pr, deadline)
    saveTasks(FILE_NAME)
    refreshList(taskList)
  except:
    echo "Invalid input"

let completeBtn = newButton(window, "Complete Task", 10, 310, 150, 25)
completeBtn.onClick = proc() =
  if taskList.selectedItem.len > 0:
    let idx = parseInt(taskList.selectedItem.split(":")[0])
    completeTask(idx)
    saveTasks(FILE_NAME)
    refreshList(taskList)

let removeBtn = newButton(window, "Remove Task", 170, 310, 150, 25)
removeBtn.onClick = proc() =
  if taskList.selectedItem.len > 0:
    let idx = parseInt(taskList.selectedItem.split(":")[0])
    removeTask(idx)
    saveTasks(FILE_NAME)
    refreshList(taskList)

window.show()
