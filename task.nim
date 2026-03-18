import times

type
  Task* = object
    description*: string
    priority*: int
    completed*: bool
    createdAt*: Time
    deadline*: Time
