import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/services/preferences_manager.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/widgets/sliver_task_list_widget.dart';

import '../widgets/achieved_tasks_widget.dart';
import '../widgets/custom_svg_picture.dart';
import '../widgets/high_priority_task_widget.dart';
import '../widgets/task_list_widget.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadTask();
  }

  void _loadUserName() async {
    setState(() {
      username = PreferencesManager().getString("username");
    });
  }

  void _loadTask() async {
    setState(() {
      isLoading = false;
    });
    final finalTask = PreferencesManager().getString("tasks");
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        tasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        _calculatePercent();
      });

      setState(() {
        isLoading = false;
      });
    }
  }



  void _doneTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
      _calculatePercent();
    });

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString("tasks", jsonEncode(updatedTask));
  }

  void _deleteTask(int? id) async {
    if(id == null) return;

    setState(() {
      tasks.removeWhere((task) => task.id == id);
      _calculatePercent();
    });
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString("tasks", jsonEncode(updatedTask));
  }

  _calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks
        .where((e) => e.isDone)
        .length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/youssef_photo.jpeg",
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Evening , $username",
                            style: Theme.of(context).textTheme.titleMedium
                          ),
                          Text(
                            "One task at a time . One step\ncloser.",
                            style: Theme.of(context).textTheme.titleSmall
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Yuhuu , Your work is",
                    style: Theme.of(context).textTheme.displayLarge
                  ),
                  Row(
                    children: [
                      Text(
                        "almost done ! ",
                        style: Theme.of(context).textTheme.displayLarge
                      ),
                      CustomSvgPicture.withoutColor(
                          path : "assets/images/waving_hand.svg",
                        width: 32,
                        height: 32,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  AchievedTasksWidget(
                    totalTasks: totalTasks,
                    totalDoneTasks: totalDoneTasks,
                    percent: percent,
                  ),
                  SizedBox(height: 8),
                  HighPriorityTaskWidget(
                    tasks: tasks,
                    onTap: (bool? value, int? index) {
                      _doneTask(value, index);
                    },
                    refresh: () {
                      _loadTask();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Text(
                      "My Tasks",
                      style: Theme.of(context).textTheme.labelSmall
                    ),
                  ),
                  SizedBox(height: 16)
                ],
              ),
            ),
            isLoading
                ? SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            )
                : SliverPadding(
              padding:EdgeInsets.only(bottom: 60),
              sliver: SliverTaskListWidget(
                tasks: tasks,
                onTap: (bool? value, int? index) {
                  _doneTask(value, index);
                },
                emptyMessage: 'No Tasks Added Yet',
                onDelete: (int? id) {
                  _deleteTask(id);
              }, onEdit: (){
                  _loadTask();
              },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 44,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AddTask();
                },
              ),
            );
            print(result);
            if (result != null && result == true) {
              _loadTask();
            }
          },

          label: Text("Add New Task"),
          icon: Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
