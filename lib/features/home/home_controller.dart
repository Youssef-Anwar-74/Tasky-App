import 'package:flutter/cupertino.dart';
import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';

class HomeController with ChangeNotifier {
  String? username;
  String? userImagePath;
  String? motivationQuote;
  bool isLoading = false;

  init() {
    loadUserData();
  }

  void loadUserData() async {
    username = PreferencesManager().getString(StorageKey.username);
    userImagePath = PreferencesManager().getString(StorageKey.userImage);
    motivationQuote = PreferencesManager().getString(StorageKey.motivationQuote) ??
        "One task a time , One step closer";
    notifyListeners();
  }
}
