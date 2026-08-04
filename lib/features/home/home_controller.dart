import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:tasky_app/models/task_model.dart';
import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> tasksList = [];
  String? username;
  String? userImagePath;
  bool isLoading = false;

  init() {
    loadUserData();
  }

  void loadUserData() async {
    username = PreferencesManager().getString(StorageKey.username);
    userImagePath = PreferencesManager().getString(StorageKey.userImage);
    notifyListeners();
  }

}
