import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky_app/core/widgets/custom_check_box.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/core/components/task_item_widget.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';

class SliverTaskListWidget extends StatefulWidget {
  const SliverTaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyMessage,
    required this.onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function(int?) onDelete;
  final Function onEdit;
  final String emptyMessage;

  @override
  State<SliverTaskListWidget> createState() => _SliverTaskListWidgetState();
}

class _SliverTaskListWidgetState extends State<SliverTaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.tasks.isEmpty
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
            itemCount: widget.tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return TaskItemWidget(
                model: widget.tasks[index],
                onChanged: (bool? value) {
                  widget.onTap(value , index);
                }, onDelete: (int id) {
                  widget.onDelete(id);
              }, onEdit: (){
                  widget.onEdit();
              },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
          );
  }
}
