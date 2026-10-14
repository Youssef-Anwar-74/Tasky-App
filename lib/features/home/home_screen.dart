import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/features/home/home_controller.dart';
import 'package:tasky_app/features/home/components/sliver_task_list_widget.dart';
import 'package:tasky_app/features/tasks/tasks_controller.dart';
import 'components/achieved_tasks_widget.dart';
import 'components/high_priority_task_widget.dart';
import '../../core/widgets/custom_svg_picture.dart';
import '../add_task/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController()..init(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(AppSizes.ph16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Selector<HomeController, String?>(
                          selector: (context, HomeController controller) =>
                              controller.userImagePath,
                          builder:
                              (
                                BuildContext context,
                                userImagePath,
                                Widget? child,
                              ) {
                                return CircleAvatar(
                                  backgroundImage: (userImagePath == null ||
                                          !File(userImagePath).existsSync())
                                      ?  AssetImage(
                                          "assets/images/avatar.jpg",
                                        )
                                      : FileImage(File(userImagePath))
                                            as ImageProvider,
                                );
                              },
                        ),
                        SizedBox(width: AppSizes.w8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Selector<HomeController, String?>(
                                selector:
                                    (context, HomeController controller) =>
                                        controller.username,
                                builder:
                                    (
                                      BuildContext context,
                                      String? username,
                                      Widget? child,
                                    ) {
                                      return Text(
                                        "Good Evening , ${username ?? ''}",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                        overflow: TextOverflow.ellipsis,
                                      );
                                    },
                              ),
                              Selector<HomeController, String?>(
                                selector:
                                    (context, HomeController controller) =>
                                        controller.motivationQuote,
                                builder:
                                    (
                                      BuildContext context,
                                      String? motivationQuote,
                                      Widget? child,
                                    ) {
                                      return Text(
                                        motivationQuote ?? '',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleSmall,
                                        overflow: TextOverflow.ellipsis,
                                      );
                                    },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.h16),
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
                          width: AppSizes.w32,
                          height: AppSizes.h32,
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.h16),
                    AchievedTasksWidget(),
                     SizedBox(height: AppSizes.h8),
                    HighPriorityTaskWidget(),
                    Padding(
                      padding:  EdgeInsets.only(top: AppSizes.ph24 , bottom: AppSizes.ph16),
                      child: Text(
                        "My Tasks",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                    SizedBox(height: AppSizes.h16),
                  ],
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(bottom: 60),
                sliver: SliverTaskListWidget(
                  emptyMessage: 'No Tasks Added Yet',
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          height: AppSizes.h44,
          child: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
                onPressed: () async {
                  final bool? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const AddTaskScreen();
                      },
                    ),
                  );
                  if (result != null && result == true) {
                    if (context.mounted) {
                      context.read<TasksController>().init();
                    }
                  }
                },
                label: const Text("Add New Task"),
                icon: const Icon(Icons.add),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.r30),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
