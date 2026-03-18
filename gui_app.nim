import os, strutils, times
import task, todo_manager
import nimterop # Tkinter bindings (Tk)

# Load tasks
const FILE_NAME = "tasks.txt"
loadTasks(FILE_NAME)

# GUI Functions
proc refreshList(lst: var seq[string]) =
  lst.setItems(@[])
  for i, t in tasks:
    let status = if t.completed: "[✔]" else: "[ ]"
    lst.addItem($i & ": " & status & " " & t.description & " (Priority: " & $t.priority & ")")

proc addTaskGUI(desc: string, pr: int, deadlineStr: string, lst: var seq[string]) =
  try:
    let deadline = parse(deadlineStr, "yyyy-MM-dd")
    addTask(desc, pr, deadline)
    saveTasks(FILE_NAME)
    refreshList(lst)
  except:
    echo "Invalid date or input"

proc completeTaskGUI(index: int, lst: var seq[string]) =
  completeTask(index)
  saveTasks(FILE_NAME)
  refreshList(lst)

proc removeTaskGUI(index: int, lst: var seq[string]) =
  removeTask(index)
  saveTasks(FILE_NAME)
  refreshList(lst)

# --- GUI Mockup ---
# NOTE: Nimx or Tk bindings would create a window with:
# - Listbox for tasks
# - Entry fields for description, priority, deadline
# - Buttons: Add, Complete, Remove
# For full GUI, use Nimx for better cross-platform support
