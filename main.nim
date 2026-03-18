import todo_manager, strutils, times

const FILE_NAME = "tasks.txt"

proc main() =
  loadTasks(FILE_NAME)

  while true:
    echo "\n==== TODO LIST ===="
    echo "1. Add Task"
    echo "2. List Tasks"
    echo "3. Complete Task"
    echo "4. Remove Task"
    echo "5. Save Tasks"
    echo "6. Exit"

    stdout.write("Choose an option: ")
    let choice = readLine(stdin)

    case choice
    of "1":
      stdout.write("Enter description: ")
      let desc = readLine(stdin)

      stdout.write("Enter priority (1-5): ")
      let pr = parseInt(readLine(stdin))

      stdout.write("Enter deadline (YYYY-MM-DD): ")
      let dateStr = readLine(stdin)

      try:
        let deadline = parse(dateStr, "yyyy-MM-dd")
        addTask(desc, pr, deadline)
      except:
        echo "Invalid date format."

    of "2":
      listTasks()

    of "3":
      stdout.write("Enter task number: ")
      let idx = parseInt(readLine(stdin))
      completeTask(idx)

    of "4":
      stdout.write("Enter task number: ")
      let idx = parseInt(readLine(stdin))
      removeTask(idx)

    of "5":
      saveTasks(FILE_NAME)
      echo "Tasks saved."

    of "6":
      saveTasks(FILE_NAME)
      echo "Goodbye!"
      break

    else:
      echo "Invalid option."

main()
