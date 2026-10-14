import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:tasky_app/core/constants/constants.dart';
import 'package:tasky_app/hive_registrar.g.dart';
import 'package:tasky_app/models/task_model.dart';

class HiveStorageManager {
  static final HiveStorageManager _instance = HiveStorageManager._();

  HiveStorageManager._();

  factory HiveStorageManager() {
    return _instance;
  }

  late Box<TaskModel> _taskBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapters();

    _taskBox = await Hive.openBox<TaskModel>(Constants.tasksNameCollection);
  }

  Future<void> saveTasks(List<TaskModel> list) async {
    await _taskBox.clear();
    await _taskBox.addAll(list);
  }

  List<TaskModel> loadTasks() {
    return _taskBox.values.toList();
  }

  Future<void> clear() async {
    await _taskBox.clear();
  }
}
