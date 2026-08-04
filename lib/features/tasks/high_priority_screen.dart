import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/features/tasks/tasks_controller.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';
import '../../models/task_model.dart';
import '../../core/components/task_list_widget.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
    return Scaffold(
      appBar: AppBar(title: Text("High Priority Tasks")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: controller.isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : Consumer<TasksController>(
                builder: (BuildContext context, value, Widget? child) {
                  return TaskListWidget(
                    tasks: value.highPriorityTasks,
                    onTap: (bool? value, int? index) async {
                      controller.doneHighPriorityTask(value, index);
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
    );
  }
}
