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
      tasks = taskAfterDecode.map((element) => TaskModel.fromJson(element)).toList();
      _loadDate();

      _calculatePercent();
    }
    isLoading = false;
    notifyListeners();
  }

  void _loadDate(){
    todoTasks = tasks.where((element) => !element.isDone).toList();
    completedTasks = tasks.where((element) => element.isDone).toList();
    highPriorityTasks = tasks.where((element) => element.isHighPriority).toList();
    highPriorityTasks = highPriorityTasks.reversed.toList();
  }

  void doneTask(bool? value, int id) async {

    final TaskModel model = tasks.firstWhere((element) => element.id == id);
    final index = tasks.indexWhere((element) => element.id == id);

    tasks[index].isDone = value ?? false;
    _loadDate();
    _calculatePercent();

    final updatedTask = tasks.map((element)=> element.toJson()).toList();

    await PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));
    _loadTasks();
  }



  void deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((e) => e.id == id);
    _loadDate();
    _calculatePercent();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    _calculatePercent();

    notifyListeners();
  }

  void _calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }

  void clearTasks() {
    tasks.clear();
    completedTasks.clear();
    todoTasks.clear();
    highPriorityTasks.clear();

    totalTasks = 0;
    totalDoneTasks = 0;
    percent = 0;

    notifyListeners();
  }

}
