import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  // ListTile widget that represents the actual task
  // Will show task title, completion status and menu options (to handle edit, delete, toggle priority)
  TaskCard(
    {
      required this.togglePriorityFunc,
      required this.deleteTaskFunc,
      required this.taskTitle,
      required this.theColor,
      required this.editTaskFunc,
      required this.leadingWidget
    }
  );

  // instance variable
  final Widget taskTitle;
  final VoidCallback? deleteTaskFunc;
  final VoidCallback? editTaskFunc;
  final VoidCallback? togglePriorityFunc;
  final Color theColor;
  final Widget leadingWidget;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            leading: leadingWidget,
            tileColor: theColor,
            title: taskTitle,
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text("Edit"),
                  onTap: editTaskFunc,
                ),
                PopupMenuItem(
                  child: const Text("Delete"),
                  onTap: deleteTaskFunc,
                ),
                PopupMenuItem(
                  child: const Text("Toggle priority"),
                  onTap: togglePriorityFunc,
                )
              ],
            )
        ),
    );
  }
}

