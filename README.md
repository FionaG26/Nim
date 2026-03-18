# 📝 Nim Todo List Project

A **cross-platform Todo List application** built in **Nim**.
This project demonstrates Nim’s capabilities across multiple interfaces:

* **Command-Line Interface (CLI)**
* **REST API** using Jester
* **Graphical User Interface (GUI)** using Nimx

It includes **persistent storage**, **task deadlines**, **priority sorting**, and **modular code design**.

---

## 📁 Project Structure

```text
nim-todo-project/
│
├── main.nim           # CLI interface
├── rest_api.nim       # REST API server (Jester)
├── gui_app.nim        # GUI application (Nimx)
├── todo_manager.nim   # Core logic and task operations
├── task.nim           # Task object definition
├── tasks.txt          # Persisted tasks (auto-created)
└── README.md          # Project documentation
```

---

## 🧩 Features

* Add tasks with description, priority, and deadline
* List all tasks with completion status
* Mark tasks as completed
* Remove tasks
* Tasks saved to `tasks.txt` for persistence
* CLI supports colored output for readability
* Automatic sorting by task priority
* REST API endpoints for web or mobile integration
* GUI application with live task list and interactive buttons
* Modular design for easy extension

---

## 🧠 Concepts Covered

This project is perfect for learning Nim fundamentals and advanced topics:

* Nim syntax and indentation
* Custom object types (`Task`)
* Sequences (dynamic arrays)
* Procedures, modules, and imports
* Error handling (`try/except`)
* File I/O for persistence
* Sorting and filtering data
* REST API with Jester
* GUI development with Nimx
* Time handling with deadlines and timestamps

---

## ⚙️ Installation Instructions (Linux)

### 1. Install Nim

```bash
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
nim -v
```

---

### 2. Clone the Project

```bash
git clone https://github.com/yourusername/nim-todo-project.git
cd nim-todo-project
```

---

### 3. Install Dependencies

**REST API**:

```bash
nimble install jester
```

**GUI Version**:

```bash
nimble install nimx
# Install required system libraries on Linux
sudo apt install libsdl2-dev libcairo2-dev
```

---

## ▶️ Running the Project

### CLI Version

```bash
nim c -r main.nim
```

* Navigate the menu to add, list, complete, remove, and save tasks.

---

### REST API Version

```bash
nimble c -r rest_api.nim
```

* Runs on **[http://localhost:5000](http://localhost:5000)**
* Example requests with `curl`:

```bash
# List tasks
curl http://localhost:5000/tasks

# Add task
curl -X POST http://localhost:5000/tasks \
     -H "Content-Type: application/json" \
     -d '{"description":"Buy groceries","priority":2,"deadline":"2026-03-20"}'

# Complete task
curl -X PUT http://localhost:5000/tasks/0/complete

# Delete task
curl -X DELETE http://localhost:5000/tasks/0
```

---

### GUI Version

```bash
nimble c -r gui_app.nim
```

* Opens a GUI window with:

  * Task list display
  * Entry fields for description, priority, deadline
  * Buttons to Add, Complete, Remove tasks

---

## 💾 Data Persistence

* All tasks are saved in `tasks.txt` automatically.
* File format:

```
description|priority|completed|createdAt|deadline
```

Example:

```
Finish Nim README|2|false|1678534800|1678621200
Buy groceries|1|true|1678538400|1678624800
```

> All interfaces (CLI, GUI, REST API) share the same file.

---

## 🛠️ Possible Improvements

* 🎨 **Colored CLI output** (highlight completed, pending, overdue tasks)
* 🔢 **Sort tasks by priority**
* ⏱️ **Add deadlines and timestamps**
* 🖥️ **GUI enhancements**: buttons, calendar picker, drag-and-drop
* 🌐 **REST API improvements**: authentication, JSON validation, web frontend
* ⚡ **Cross-platform packaging**: Linux, macOS, Windows executables
* 📦 **Integration with databases** for larger-scale task storage

---

## 🔗 REST API Endpoints

| Method | Endpoint              | Description            |
| ------ | --------------------- | ---------------------- |
| GET    | `/tasks`              | List all tasks         |
| POST   | `/tasks`              | Add a new task         |
| PUT    | `/tasks/:id/complete` | Mark task as completed |
| DELETE | `/tasks/:id`          | Remove task            |

---

## 🖥️ GUI Layout

* **ListBox**: displays tasks
* **TextBox**: for task description, priority, deadline
* **Buttons**: Add, Complete, Remove

> GUI interacts directly with `tasks.txt` for persistence.

---

## 💻 Why Nim?

* Python-like readability
* C-level performance
* Powerful compile-time features (macros, templates)
* Multi-paradigm: imperative, functional, object-oriented
* Ideal for learning **systems programming**, **scripting**, and **application development**

---

## 👩‍💻 Author

Fiona Githaiga
