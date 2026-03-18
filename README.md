# 📝 Nim Command-Line Todo List Manager

A simple, modular command-line Todo List application built in **Nim**.
This project demonstrates core Nim concepts including data structures, procedures, modules, error handling, and file I/O.

---

## 🚀 Features

* Add new tasks with priority levels
* List all tasks with completion status
* Mark tasks as completed
* Remove tasks
* Persistent storage (save/load tasks from file)
* Modular code structure

---

## 📁 Project Structure

```
.
├── main.nim           # Entry point (CLI interface)
├── todo_manager.nim   # Core logic and task operations
├── task.nim           # Task data model
└── tasks.txt          # Stored tasks (auto-created)
```

---

## 🧠 Concepts Covered

This project is useful for learning:

* Nim syntax and indentation
* Custom object types
* Sequences (dynamic arrays)
* Procedures (functions)
* Modules and imports
* Error handling with `try/except`
* File I/O (read/write persistence)

---

## ⚙️ Installation

### 1. Install Nim

Download Nim from the official site:

👉 [https://nim-lang.org/install.html](https://nim-lang.org/install.html)

Verify installation:

```bash
nim -v
```

---

## ▶️ Running the Application

Compile and run:

```bash
nim c -r main.nim
```

---

## 💻 Usage

Once running, you’ll see a menu:

```
==== TODO LIST ====
1. Add Task
2. List Tasks
3. Complete Task
4. Remove Task
5. Save Tasks
6. Exit
```

Follow prompts to interact with your todo list.

---

## 💾 Data Persistence

* Tasks are saved to `tasks.txt`
* Data format:

```
description|priority|completed
```

Example:

```
Finish assignment|2|false
Buy groceries|1|true
```

---

## 🧪 Example Workflow

```text
> Add Task
> "Write Nim README"
> Priority: 2

> List Tasks
0: [ ] Write Nim README (Priority: 2)

> Complete Task
> 0

0: [✔] Write Nim README (Priority: 2)
```

---

## 🛠️ Possible Improvements

* Add colored CLI output
* Sort tasks by priority
* Add deadlines or timestamps
* Build a GUI version
* Convert into a REST API

---

## 📚 Why Nim?

Nim combines:

* Python-like readability
* C-level performance
* Powerful metaprogramming

This makes it great for both learning and building efficient applications.

---

## 👩‍💻 Author

Fiona Githaiga
