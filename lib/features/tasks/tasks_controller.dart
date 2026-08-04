import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tasky_app/models/task_model.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';

class TasksController extends ChangeNotifier {
  bool isLoading = false;
  List<TaskModel> tasks = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> highPriorityTasks = [];
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;


  init() {
    _loadTasks();
  }

  void _loadTasks() {
    isLoading = true;

    final finalTask = PreferencesManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      todoTasks = tasks.where((element) => !element.isDone).toList();
      completedTasks = tasks.where((element) => element.isDone).toList();


      highPriorityTasks = tasks.where((element) => element.isHighPriority).toList();
      highPriorityTasks = highPriorityTasks.reversed.toList();
      calculatePercent();
    }
    isLoading = false;
    notifyListeners();
  }

  void doneTask(bool? value, int? index) async {
    tasks[index!].isDone = value ?? false;
    calculatePercent();

    final updatedTask = tasks.map((element)=> element.toJson()).toList();

    await PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));
    _loadTasks();
  }

  void doneTodoTask(bool? value, int? index) async {
    if (index == null) return;
    todoTasks[index].isDone = value ?? false;
    calculatePercent();

    final newIndex = tasks.indexWhere(
          (element) => element.id == todoTasks[index].id,
    );
    tasks[newIndex] = todoTasks[index];

    await PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));
    _loadTasks();
  }


  void doneCompleteTask(bool? value, int? index) async {
    if (index == null) return;
    completedTasks[index].isDone = value ?? false;

    final newIndex = tasks.indexWhere(
      (element) => element.id == completedTasks[index].id,
    );
    tasks[newIndex] = completedTasks[index];

    await PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));
    _loadTasks();
  }

  void doneHighPriorityTask(bool? value, int? index) async {
    if (index == null) return;
    highPriorityTasks[index].isDone = value ?? false;

    final newIndex = tasks.indexWhere(
          (element) => element.id == highPriorityTasks[index].id,
    );
    tasks[newIndex] = highPriorityTasks[index];

    await PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));
    _loadTasks();
  }

  void deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((e) => e.id == id);
    todoTasks.removeWhere((task) => task.id == id);
    completedTasks.removeWhere((task) => task.id == id);
    highPriorityTasks.removeWhere((task) => task.id == id);

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    calculatePercent();

    notifyListeners();
  }

  calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }

}
