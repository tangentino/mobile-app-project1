import 'package:flutter/material.dart';

import 'controllers/task_controller.dart';
import 'components/task_card.dart';
import 'components/task_dialog.dart';
import 'components/task_checkbox.dart';


class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  TaskController taskController = TaskController();

  List<Task> priorityTasks = <Task>[];
  List<Task> optionalTasks = <Task>[];

  final TextEditingController textEditingController = TextEditingController();

  int _navSelectedIndex = 0;

  void _navOnTap(int index) {
    setState(() {
      _navSelectedIndex = index;
    });
  }

  List<Task> _taskList() {
    // Filter TaskController based on navigation bar selection
    // If user is on Priority Task tab, then only show Priority Tasks etc.
    if (_navSelectedIndex == 0) {
      return taskController.getPriorityTasks();
    }
    else {
      return taskController.getOptionalTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("To-Do List"),
          // actions: <Widget>[
          //   TextButton(
          //     style: TextButton.styleFrom(
          //       primary: Colors.white,
          //       textStyle: const TextStyle(fontSize: 10)
          //     ),
          //     child: const Text("REMOVE ALL COMPLETED"),
          //     onPressed: () {
          //       setState(() {
          //         taskController.removeAllCompletedTasks();
          //       });
          //     },
          //   )
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(7.5),
          child: ListView.builder(
            itemCount: _taskList().length,
            itemBuilder: (context, index) =>
                TaskCard(
                  leadingWidget: TaskCheckbox(
                    toggleCheck: _taskList()[index].isDone,
                    onTapFunc: () {
                      setState(() {
                        // Toggle task complete status
                        taskController.toggleTaskComplete(_taskList()[index]);
                      });
                    },
                  ),
                  theColor: _taskList()[index].isPriority ? Colors.amber : Colors.white,
                  taskTitle: Text(
                      _taskList()[index].text,
                      style: TextStyle(
                        // If task is completed, text is strike through with lower opacity
                        fontSize: 20,
                        decoration: _taskList()[index].isDone ? TextDecoration.lineThrough : TextDecoration.none,
                        color: _taskList()[index].isDone ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(1.0)
                      )
                  ),
                  editTaskFunc: () {
                    // Get current task text and set to TextEditingController
                    textEditingController.text = _taskList()[index].text;
                    Future.delayed(
                      // Closing the popup menu of the task card will also call Navigator.of(context).pop()
                      // This results in dialog popup being instantly closed as well
                      // So I added Future.delayed() to stop dialog box disappearing
                      const Duration(seconds: 0),
                          () =>
                          TaskDialog(
                            // Popup dialog to edit task
                            dialogTextController: textEditingController,
                            alertDialogTitle: "Edit task",
                            alertDialogHintText: "",
                            confirmButtonFunc: () {
                              Navigator.of(context).pop();

                              setState(() {
                                _taskList()[index].text = textEditingController.text;
                              });
                            }
                          ).newTaskDialog(context)
                    );
                  },
                  deleteTaskFunc: () {
                    // Delete task
                    setState(() {
                      taskController.removeTaskByHashCode(_taskList()[index].hashCode);
                    });
                  },
                  togglePriorityFunc: () {
                    // Toggle task priority
                    setState(() {
                      taskController.toggleTaskPriority(_taskList()[index]);
                    });
                  },
                ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Pop up dialog to add new task
              // Conditional based on nav bar
              // If user is on priority task list, add new priority task etc.
              textEditingController.clear();
              TaskDialog(
                  dialogTextController: textEditingController,
                  alertDialogTitle: _navSelectedIndex == 0 ? "Add priority task" : "Add optional task",
                  alertDialogHintText: "Enter task here",
                  confirmButtonFunc: () {
                    Navigator.of(context).pop();

                    setState(() {
                      if (_navSelectedIndex == 0) {
                        taskController.addTask(textEditingController.text, true);
                      }
                      else {
                        taskController.addTask(textEditingController.text, false);
                      }
                    });
                  }
              ).newTaskDialog(context);
            },
            child: const Icon(Icons.add),
            backgroundColor: _navSelectedIndex == 0 ? Colors.pinkAccent : Colors.blue
        ),
        bottomNavigationBar: BottomNavigationBar(
          // Bottom navigation bar to switch between "priority" (must-do) tasks and "optional" tasks
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.announcement),
              label: "Priority Tasks",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: "Optional Tasks",
            )
          ],
          currentIndex: _navSelectedIndex,
          onTap: _navOnTap,
        ),
      ),
    );
  }
}
