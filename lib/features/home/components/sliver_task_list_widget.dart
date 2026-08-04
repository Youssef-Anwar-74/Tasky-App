import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/widgets/custom_check_box.dart';
import 'package:tasky_app/features/home/home_controller.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/core/components/task_item_widget.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';

import '../../tasks/tasks_controller.dart';

class SliverTaskListWidget extends StatefulWidget {
  const SliverTaskListWidget({
    super.key,
    required this.emptyMessage,
  });

  final String emptyMessage;

  @override
  State<SliverTaskListWidget> createState() => _SliverTaskListWidgetState();
}

class _SliverTaskListWidgetState extends State<SliverTaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, TasksController controller, Widget? child) {
        return controller.isLoading
            ? SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        )
            :
        controller.tasks.isEmpty
            ? SliverToBoxAdapter(
          child: Center(
            child: Text(
              "No Tasks Added Yet",
              style: GoogleFonts.aclonica(
                fontSize: 24,
                color: Color(0xFFFFFCFC),
              ),
            ),
          ),
        )
            : SliverList.separated(
          itemCount: controller.tasks.length,
          itemBuilder: (BuildContext context, int index) {
            return TaskItemWidget(
              model: controller.tasks[index],
              onChanged: (bool? value) {
                controller.doneTask(value, index);
              }, onDelete: (int id) {
             controller.deleteTask(id);
            }, onEdit: (){
             controller.init();
            },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 8);
          },
        );
      },
    );
  }
}
