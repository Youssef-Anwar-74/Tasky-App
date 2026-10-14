import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tasky_app/core/services/file_storage_manager.dart';
import 'package:tasky_app/models/task_model.dart';

import '../../core/constants/storage_key.dart';

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

  void _loadTasks() async{
    isLoading = true;


      final tasksData = await FileStorageManager().loadTasks();

      tasks = tasksData.map((element) => TaskModel.fromJson(element)).toList();
      _loadDate();

      _calculatePercent();
    isLoading = false;
    notifyListeners();
  }

  void _loadDate()async{
    await FileStorageManager().loadTasks();
    todoTasks = tasks.where((element) => !element.isDone).toList();
    completedTasks = tasks.where((element) => element.isDone).toList();
    highPriorityTasks = tasks.where((element) => element.isHighPriority).toList();
    highPriorityTasks = highPriorityTasks.reversed.toList();
  }

  void doneTask(bool? value, int id) async {

    //final TaskModel model = tasks.firstWhere((element) => element.id == id);
    final index = tasks.indexWhere((element) => element.id == id);

    tasks[index].isDone = value ?? false;
    _loadDate();
    _calculatePercent();

    final updatedTask = tasks.map((element)=> element.toJson()).toList();

    await FileStorageManager().saveTasks(updatedTask);
    //_loadTasks();
    notifyListeners();
  }



  void deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((e) => e.id == id);
    _loadDate();
    _calculatePercent();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await FileStorageManager().saveTasks(updatedTask);
    notifyListeners();
  }

  void _calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }

  // void clearTasks() {
  //   tasks.clear();
  //   completedTasks.clear();
  //   todoTasks.clear();
  //   highPriorityTasks.clear();
  //
  //   totalTasks = 0;
  //   totalDoneTasks = 0;
  //   percent = 0;
  //
  //   notifyListeners();
  // }

  void clearTasks(){
    _loadTasks();
  }

}
