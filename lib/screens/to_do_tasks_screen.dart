import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/services/preferences_manager.dart';
import 'package:tasky_app/models/task_model.dart';

import '../widgets/task_list_widget.dart';

class ToDoTasksScreen extends StatefulWidget {
  const ToDoTasksScreen({super.key});

  @override
  State<ToDoTasksScreen> createState() => _ToDoTasksScreenState();
}

class _ToDoTasksScreenState extends State<ToDoTasksScreen> {
  List<TaskModel> todoTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    setState(() {
      isLoading = false;
    });
    final pref = await SharedPreferences.getInstance();
    final finalTask = PreferencesManager().getString("tasks");
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        todoTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        todoTasks = todoTasks.where((element) => !element.isDone).toList();
      });

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.white))
                : TaskListWidget(
                    tasks: todoTasks,
                    onTap: (bool? value, int? index) async {
                      setState(() {
                        todoTasks[index!].isDone = value ?? false;
                      });

                      final pref = await SharedPreferences.getInstance();

                      final allData = PreferencesManager().getString("tasks");

                      if (allData != null) {
                        List<TaskModel> allDataList =
                            (jsonDecode(allData) as List)
                                .map((element) => TaskModel.fromJson(element))
                                .toList();

                        final newIndex = allDataList.indexWhere(
                          (element) => element.id == todoTasks[index!].id,
                        );
                        allDataList[newIndex] = todoTasks[index!];

                        await PreferencesManager().setString("tasks", jsonEncode(allDataList));
                        _loadTask();
                      }
                    },
                    emptyMessage: 'No Tasks Found',
                  ),
          ),
        ),
      ],
    );
  }
}
