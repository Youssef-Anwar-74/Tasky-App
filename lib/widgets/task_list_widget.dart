import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/widgets/task_item_widget.dart';

import '../core/widgets/custom_check_box.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyMessage,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final String emptyMessage;

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.tasks.isEmpty
        ? Center(
            child: Text(
              "No Tasks Added Yet",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          )
        : ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 55),
            itemCount: widget.tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return TaskItemWidget(
                model: widget.tasks[index],
                onChanged: (bool? value) {
                  widget.onTap(value , index);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
          );
  }
}
