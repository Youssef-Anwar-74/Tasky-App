import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/services/preferences_manager.dart';
import 'package:tasky_app/main.dart';
import 'package:tasky_app/features/profile/user_details_screen.dart';
import 'package:tasky_app/features/welcome/welcome_screen.dart';

import '../../core/theme/theme_controller.dart';
import '../../core/widgets/custom_svg_picture.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  late String motivationQuote;
  String? userImagePath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    setState(() {
      username = PreferencesManager().getString("username") ?? "";
      motivationQuote =
          PreferencesManager().getString("motivation_quote") ??
          "One task a time . One step closer.";
      userImagePath = PreferencesManager().getString("user_image");
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator(color: Colors.white))
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    "My Profile",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                SizedBox(height: 18),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundImage: userImagePath != null
                                ? FileImage(File(userImagePath!))
                                : AssetImage(
                                    "assets/images/youssef_photo.jpeg",
                                  ) as ImageProvider,
                            radius: 60,
                          ),
                          GestureDetector(
                            onTap: () async {
                              showImageSourceDialog(
                                context,
                                (XFile image) {
                                  _saveImage(image);
                                  setState(() {
                                    userImagePath = image.path;
                                  });
                                },
                              );
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(Icons.camera_alt, size: 28),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        username,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        motivationQuote,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Profile Info",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 24),
                ListTile(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return UserDetailsScreen(
                            userName: username,
                            motivationQuote: motivationQuote,
                          );
                        },
                      ),
                    );
                    if (result != null && result == true) {
                      _loadData();
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text("User Details"),
                  leading: CustomSvgPicture(path: 'assets/images/profile.svg'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Dark Mode"),
                  leading: CustomSvgPicture(path: 'assets/images/dark.svg'),
                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeController.themeNotifier,
                    builder: (BuildContext context, value, Widget? child) {
                      return Switch(
                        value: value == ThemeMode.dark,
                        onChanged: (bool value) async {
                          await ThemeController.toggleTheme();
                        },
                      );
                    },
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () async {
                    PreferencesManager().remove("username");
                    PreferencesManager().remove("motivation_quote");
                    PreferencesManager().remove("tasks");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return WelcomeScreen();
                        },
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text("Log Out"),
                  leading: CustomSvgPicture(path: 'assets/images/log_out.svg'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          );
  }

  void _saveImage(XFile file) async {
    final appDir = (await getApplicationDocumentsDirectory());
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    PreferencesManager().setString("user_image", newFile.path);
  }
}

void showImageSourceDialog(BuildContext context, Function(XFile) selectedFile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(
          "Select Image Source",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
              );
              if (image != null) {
                selectedFile(image);
              }
            },
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 16),
                Text("Camera", style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                selectedFile(image);
              }
            },
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.photo_library),
                SizedBox(width: 16),
                Text("Gallery", style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
        ],
      );
    },
  );
}
