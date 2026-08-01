import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/services/preferences_manager.dart';
import 'package:tasky_app/features/home/home_controller.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/features/home/components/sliver_task_list_widget.dart';

import '../../core/constants/storage_key.dart';
import 'components/achieved_tasks_widget.dart';
import 'components/high_priority_task_widget.dart';
import '../../core/widgets/custom_svg_picture.dart';
import '../../core/components/task_list_widget.dart';
import '../add_task/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController()..init(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, HomeController value, Widget? child) {
          final HomeController controller = context.read<HomeController>();
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
                              backgroundImage: value.userImagePath == null
                                  ? AssetImage(
                                      "assets/images/youssef_photo.jpeg",
                                    )
                                  : FileImage(File(value.userImagePath!))
                                        as ImageProvider,
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Good Evening , ${value.username}",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  "One task at a time . One step\ncloser.",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Yuhuu , Your work is",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Row(
                          children: [
                            Text(
                              "almost done ! ",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            CustomSvgPicture.withoutColor(
                              path: "assets/images/waving_hand.svg",
                              width: 32,
                              height: 32,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        AchievedTasksWidget(
                          totalTasks: value.totalTasks,
                          totalDoneTasks: value.totalDoneTasks,
                          percent: value.percent,
                        ),
                        SizedBox(height: 8),
                        HighPriorityTaskWidget(
                          tasks: value.tasks,
                          onTap: (bool? value, int? index) {
                            controller.doneTask(value, index);
                          },
                          refresh: () {
                            controller.loadTask();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Text(
                            "My Tasks",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                  value.isLoading
                      ? SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SliverPadding(
                          padding: EdgeInsets.only(bottom: 60),
                          sliver: SliverTaskListWidget(
                            tasks: value.tasks,
                            onTap: (bool? value, int? index) {
                              controller.doneTask(value, index);
                            },
                            emptyMessage: 'No Tasks Added Yet',
                            onDelete: (int? id) {
                              controller.deleteTask(id);
                            },
                            onEdit: () {
                              controller.loadTask();
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
                    controller.loadTask();
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
        },
      ),
    );
  }
}
