class Task {
  String text;
  bool isPriority;
  bool isDone;

  Task(this.text, this.isPriority, this.isDone);
}

class TaskController {
  // Initiates a task list
  List<Task> taskList = <Task>[];

  void addTask(String text, bool isPriority) {
    taskList.add(Task(text, isPriority, false));
  }

  void removeTaskByHashCode(int code) {
    taskList.removeWhere((x) => x.hashCode == code);
  }

  List<Task> getPriorityTasks() {
    return taskList.where((x) => x.isPriority).toList();
  }

  List<Task> getOptionalTasks() {
    return taskList.where((x) => !x.isPriority).toList();
  }

  void toggleTaskPriority(Task task) {
    task.isPriority = !task.isPriority;
  }

  void toggleTaskComplete(Task task) {
    task.isDone = !task.isDone;
  }
}