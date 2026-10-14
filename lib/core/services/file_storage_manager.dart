
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageManager {
  static final FileStorageManager _instance = FileStorageManager._();

  FileStorageManager._();

  factory FileStorageManager() {
    return _instance;
  }

  late final Directory _appDocumentDirectory;
  late final File _tasksFile;

  init() async{
    _appDocumentDirectory = await getApplicationDocumentsDirectory();
    _tasksFile = File("${_appDocumentDirectory.path}/tasks.json");
  }

  saveTasks(List<dynamic> list)async{
    final listJson = jsonEncode(list);
    await _tasksFile.writeAsString(listJson);
  }

  Future<List<dynamic>> loadTasks()async{
    if (!await _tasksFile.exists()) {
      return [];
    }
    final tasksJson = await _tasksFile.readAsString();
    if (tasksJson.isEmpty) return [];
    return jsonDecode(tasksJson) as List<dynamic>;
  }

  clear()async{
    if(!await _tasksFile.exists()) return;
    await _tasksFile.delete();
  }
}