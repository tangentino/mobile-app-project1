import 'package:flutter/material.dart';

class TaskDialog {
  // Pop up dialogue with text field for users to add new task
  TaskDialog({required this.dialogTextController, required this.confirmButtonFunc, required this.alertDialogTitle, required this.alertDialogHintText});

  // instance variable
  final TextEditingController dialogTextController;
  final VoidCallback? confirmButtonFunc;
  final String alertDialogTitle;
  final String alertDialogHintText;

  Future<Future> newTaskDialog(BuildContext context) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
        AlertDialog(
          title: Text(alertDialogTitle),
          content:
            TextField(
              controller: dialogTextController,
              decoration: InputDecoration(hintText: alertDialogHintText),
            ),
          actions: <Widget>[
            TextButton(
              child: const Text("CONFIRM"),
              onPressed: confirmButtonFunc,
            ),
            TextButton(
              child: const Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        )
    );
  }
}
