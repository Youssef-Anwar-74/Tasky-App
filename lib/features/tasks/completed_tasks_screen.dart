import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/services/preferences_manager.dart';
import 'package:tasky_app/features/tasks/tasks_controller.dart';

import '../../core/constants/storage_key.dart';
import '../../models/task_model.dart';
import '../../core/components/task_list_widget.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "Completed Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: controller.isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.white))
                : Consumer<TasksController>(
                    builder: (BuildContext context, valueController, Widget? child) {
                      return TaskListWidget(
                        tasks: valueController.completedTasks,
                        onTap: (bool? value, int? index) async {
                          controller.doneTask(value, valueController.completedTasks[index!].id);
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
