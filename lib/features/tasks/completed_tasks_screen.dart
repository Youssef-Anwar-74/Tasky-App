import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/services/preferences_manager.dart';

import '../../models/task_model.dart';
import '../../core/components/task_list_widget.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  List<TaskModel> completeTasks = [];
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
    final finalTask = PreferencesManager().getString("tasks");
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        completeTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        completeTasks = completeTasks.where((element) => element.isDone == true).toList();
      });

      setState(() {
        isLoading = false;
      });
    }
  }

  void _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;

    final finalTask = PreferencesManager().getString("tasks");
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      tasks.removeWhere((e) => e.id == id);


      setState(() {
        completeTasks.removeWhere((task) => task.id == id);
      });
      final updatedTask = tasks
          .map((element) => element.toJson())
          .toList();
      PreferencesManager().setString("tasks", jsonEncode(updatedTask));
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
            "Completed Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.white))
                : TaskListWidget(
              tasks: completeTasks,
              onTap: (bool? value, int? index) async {
                setState(() {
                  completeTasks[index!].isDone = value ?? false;
                });

                final pref = await SharedPreferences.getInstance();

                final allData =PreferencesManager().getString("tasks");

                if (allData != null) {
                  List<TaskModel> allDataList = (jsonDecode(allData) as List).map((element) => TaskModel.fromJson(element)).toList();
                  final int newIndex = allDataList.indexWhere((element) => element.id == completeTasks[index!].id,);
                  allDataList[newIndex] = completeTasks[index!];

                  await PreferencesManager().setString("tasks", jsonEncode(allDataList));

                  _loadTask();
                }
              },
              emptyMessage: 'No Tasks Found',
              onDelete: (int? id) {
                _deleteTask(id);
              }, onEdit: (){
                _loadTask();
            },
            ),
          ),
        ),
      ],
    );
  }
}
