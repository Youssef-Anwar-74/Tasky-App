import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/models/task_model.dart';

import '../core/services/preferences_manager.dart';
import '../core/widgets/custom_text_form_field.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  bool isHighPriority = true;

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("New Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 20),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              SizedBox(height: 20),
              CustomTextFormField(
                title: "Task Description",
                controller: taskDescriptionController,
                maxLines: 5,
                hintText: "Finish onboarding UI and hand off to devs by Thursday",
              ),
              SizedBox(height: 20),
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
              Spacer(),
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

                    TaskModel model = TaskModel(
                      id: listTasks.length + 1,
                      taskName: taskNameController.text,
                      taskDescription: taskDescriptionController.text,
                      isHighPriority: isHighPriority,
                    );

                    listTasks.add(model.toJson());
                    final taskEncode = jsonEncode(listTasks);
                    await PreferencesManager().setString("tasks", taskEncode);

                    Navigator.of(context).pop(true);
                  }
                },
                label: Text(
                  "Add Task",
                  style: GoogleFonts.aclonica(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                icon: Icon(Icons.add, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
