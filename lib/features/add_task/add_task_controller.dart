
import 'package:flutter/cupertino.dart';
import 'package:tasky_app/core/services/hive_storage_manager.dart';

import '../../models/task_model.dart';

class AddTaskController with ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();
  bool isHighPriority = true;

  void addTask(BuildContext context)async{
    if (key.currentState?.validate() ?? false) {
      List<TaskModel> listTasks =  HiveStorageManager().loadTasks();

      TaskModel model = TaskModel(
        id: listTasks.length + 1,
        taskName: taskNameController.text,
        taskDescription: taskDescriptionController.text,
        isHighPriority: isHighPriority,
      );

      listTasks.add(model);

      await HiveStorageManager().saveTasks(listTasks);

      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}