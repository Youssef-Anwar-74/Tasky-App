import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/services/preferences_manager.dart';
import 'package:tasky_app/features/tasks/tasks_controller.dart';
import 'package:tasky_app/models/task_model.dart';

import '../../core/components/task_list_widget.dart';
import '../../core/constants/storage_key.dart';

class ToDoTasksScreen extends StatelessWidget {
  const ToDoTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "To Do Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: controller.isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.white))
                : Consumer<TasksController>(
                    builder: (BuildContext context, value, Widget? child) {
                      return TaskListWidget(
                        tasks: value.todoTasks,
                        onTap: (bool? value, int? index) async {
                          controller.doneTask(value, index);
                        },
                        emptyMessage: 'No Tasks Found',
                        onDelete: (int? id) {
                          controller.deleteTask(id);
                        },
                        onEdit: () {
                          controller.init();
                        },
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
