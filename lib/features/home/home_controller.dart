import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tasky_app/models/task_model.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> tasksList = [];
  String? username;
  String? userImagePath;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;

  init() {
    loadUserName();
    loadTask();
  }

  void loadUserName() async {
    username = PreferencesManager().getString(StorageKey.username);
    userImagePath = PreferencesManager().getString(StorageKey.userImage);

    notifyListeners();
  }

  void loadTask() async {
    isLoading = false;

    final finalTask = PreferencesManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      calculatePercent();

      isLoading = false;

      notifyListeners();
    }
  }

  void doneTask(bool? value, int? index) async {
    tasks[index!].isDone = value ?? false;
    calculatePercent();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
  }

  void deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((task) => task.id == id);
    calculatePercent();
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
  }

  calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }
}
