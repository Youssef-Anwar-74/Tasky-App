import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/features/add_task/add_task_controller.dart';
import '../../core/widgets/custom_text_form_field.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddTaskController(),
      builder: (context, _) {
        final controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text("New Task"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
              bottom: 20,
            ),
            child: Form(
              key: controller.key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    title: "Task Name",
                    controller: controller.taskNameController,
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
                    controller: controller.taskDescriptionController,
                    maxLines: 5,
                    hintText:
                        "Finish onboarding UI and hand off to devs by Thursday",
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "High Priority",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Consumer<AddTaskController>(
                        builder: (BuildContext context, value, Widget? child) {
                          return Switch(
                            value: value.isHighPriority,
                            onChanged: (bool value) {
                              controller.toggle(value);
                            },
                          );
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
                      context.read<AddTaskController>().addTask(context);
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
      },
    );
  }
}
