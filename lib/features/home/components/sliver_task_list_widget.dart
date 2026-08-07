import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/components/task_item_widget.dart';
import '../../tasks/tasks_controller.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({
    super.key,
    required this.emptyMessage,
  });

  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (BuildContext context, TasksController controller, Widget? child) {
        if (controller.isLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        }

        if (controller.tasks.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                emptyMessage,
                style: GoogleFonts.aclonica(
                  fontSize: 24,
                  color: const Color(0xFFFFFCFC),
                ),
              ),
            ),
          );
        }

        return SliverList.separated(
          itemCount: controller.tasks.length,
          itemBuilder: (BuildContext context, int index) {
            final task = controller.tasks[index];
            return TaskItemWidget(
              model: task,
              onChanged: (bool? value) {
                controller.doneTask(value, task.id);
              },
              onDelete: (int id) {
                controller.deleteTask(id);
              },
              onEdit: () {
                controller.init();
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 8);
          },
        );
      },
    );
  }
}
