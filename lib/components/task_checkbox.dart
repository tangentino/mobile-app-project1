import 'package:flutter/material.dart';

class TaskCheckbox extends StatefulWidget {
  // Checkbox widget to toggle task completion
  const TaskCheckbox({
    required this.onTapFunc,
    required this.toggleCheck
  });

  final VoidCallback? onTapFunc;
  final bool toggleCheck;

  @override
  State<TaskCheckbox> createState() => _TaskCheckboxState();
}

class _TaskCheckboxState extends State<TaskCheckbox> {

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: widget.toggleCheck ? const Icon(Icons.check_box_rounded) : const Icon(Icons.check_box_outline_blank_rounded),
      iconSize: 30.0,
      onPressed: widget.onTapFunc
    );
  }
}
