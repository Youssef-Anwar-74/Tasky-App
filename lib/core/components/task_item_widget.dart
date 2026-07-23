import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky_app/core/enums/task_item_actions_enum.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/widgets/custom_text_form_field.dart';
import 'package:tasky_app/models/task_model.dart';

import '../services/preferences_manager.dart';
import '../widgets/custom_check_box.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskModel model;
  final Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : const Color(0xFFD1DAD6),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          CustomCheckBox(
            value: model.isDone,
            onChanged: (bool? value) {
              onChanged(value);
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.taskName,
                  style: model.isDone
                      ? Theme.of(context).textTheme.titleLarge
                      : Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                if (model.taskDescription.isNotEmpty)
                  Text(
                    model.taskDescription,
                    style: GoogleFonts.aclonica(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFC6C6C6),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          PopupMenuButton<TaskItemActionsEnum>(
            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDark()
                  ? (model.isDone ? const Color(0xFFA0A0A0) : const Color(0xFFC6C6C6))
                  : (model.isDone ? const Color(0xFF6A6A6A) : const Color(0xFF3A4640)),
            ),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.delete:
                  _showAlertDialog(context);
                  break;
                case TaskItemActionsEnum.edit:
                  final result = await _showButtonSheet(context, model);
                  if (result == true) {
                    onEdit();
                  }
                  break;
              }
            },
            itemBuilder: (BuildContext context) =>
                TaskItemActionsEnum.values.map((e) {
                  return PopupMenuItem<TaskItemActionsEnum>(
                    value: e,
                    child: Text(e.name),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Delete Task",
            style: GoogleFonts.aclonica(),
          ),
          content: Text(
            "Are you sure you want to delete this task ? ",
            style: GoogleFonts.aclonica(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: GoogleFonts.aclonica(fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                onDelete(model.id);
                Navigator.pop(context);
              },
              child: Text(
                "Delete",
                style: GoogleFonts.aclonica(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showButtonSheet(BuildContext context, TaskModel model) async {
    TextEditingController taskNameController =
        TextEditingController(text: model.taskName);
    TextEditingController taskDescriptionController =
        TextEditingController(text: model.taskDescription);
    bool isHighPriority = model.isHighPriority;

    GlobalKey<FormState> _key = GlobalKey<FormState>();
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    CustomTextFormField(
                      title: "Task Name",
                      controller: taskNameController,
                      hintText: "Finish UI design for login screen",
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please Add Task Name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      title: "Task Description",
                      controller: taskDescriptionController,
                      maxLines: 5,
                      hintText: "Finish onboarding UI and hand off to devs by Thursday",
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "High Priority",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Switch(
                          value: isHighPriority,
                          onChanged: (bool value) {
                            setState(() {
                              isHighPriority = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      ),
                      onPressed: () async {
                        if (_key.currentState?.validate() ?? false) {
                          final taskJson = PreferencesManager().getString("tasks");

                          List<dynamic> listTasks = [];

                          if (taskJson != null) {
                            listTasks = jsonDecode(taskJson);
                          }

                          TaskModel newModel = TaskModel(
                            id: model.id,
                            taskName: taskNameController.text,
                            taskDescription: taskDescriptionController.text,
                            isHighPriority: isHighPriority,
                            isDone: model.isDone,
                          );

                          final item = listTasks.firstWhere((e) => e["id"] == model.id);

                          final int index = listTasks.indexOf(item);
                          listTasks[index] = newModel.toJson();

                          final taskEncode = jsonEncode(listTasks);
                          await PreferencesManager().setString("tasks", taskEncode);

                          if (context.mounted) {
                            Navigator.of(context).pop(true);
                          }
                        }
                      },
                      label: Text(
                        "Edit Task",
                        style: GoogleFonts.aclonica(),
                      ),
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
