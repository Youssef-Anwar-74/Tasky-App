import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';
import 'package:tasky_app/core/services/preferences_manager.dart';
import 'package:tasky_app/main.dart';
import 'package:tasky_app/features/profile/user_details_screen.dart';
import 'package:tasky_app/features/welcome/welcome_screen.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/file_storage_manager.dart';
import '../../core/theme/theme_controller.dart';
import '../../core/widgets/custom_svg_picture.dart';
import '../tasks/tasks_controller.dart';

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
      username = PreferencesManager().getString(StorageKey.username) ?? "";
      motivationQuote =
          PreferencesManager().getString(StorageKey.motivationQuote) ??
          "One task a time , One step closer";
      userImagePath = PreferencesManager().getString(StorageKey.userImage);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator(color: Colors.white))
        : Padding(
            padding:  EdgeInsets.all(AppSizes.w16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: AppSizes.ph8),
                  child: Text(
                    "My Profile",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                 SizedBox(height: AppSizes.h18),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: AppSizes.r60,
                            backgroundImage: (userImagePath != null &&
                                    File(userImagePath!).existsSync())
                                ? FileImage(File(userImagePath!))
                                : const AssetImage(
                                    "assets/images/default.jpeg",
                                  ) as ImageProvider,
                          ),
                          GestureDetector(
                            onTap: () async {
                              showImageSourceDialog(context, (
                                XFile image,
                              ) async {
                                final savedPath = await _saveImage(image);

                                setState(() {
                                  userImagePath = savedPath;
                                });
                              });
                            },
                            child: Container(
                              width: AppSizes.w44,
                              height: AppSizes.h44,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(AppSizes.r100),
                              ),
                              child:  Icon(Icons.camera_alt, size: AppSizes.r26),
                            ),
                          ),
                        ],
                      ),
                       SizedBox(height: AppSizes.h8),
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
                 SizedBox(height: AppSizes.h24),
                Text(
                  "Profile Info",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                 SizedBox(height: AppSizes.h24),
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
                  title: const Text("User Details"),
                  leading: const CustomSvgPicture(path: 'assets/images/profile.svg'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Dark Mode"),
                  leading: const CustomSvgPicture(path: 'assets/images/dark.svg'),
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
                const Divider(),
                ListTile(
                  onTap: () async {
                    await FileStorageManager().clear();

                    context.read<TasksController>().clearTasks();
                    
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return  WelcomeScreen();
                          },
                        ),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Log Out"),
                  leading: const CustomSvgPicture(path: 'assets/images/log_out.svg'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          );
  }

  Future<String> _saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');

    await PreferencesManager().setString(StorageKey.userImage, newFile.path);

    return newFile.path;
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
            padding:  EdgeInsets.all(AppSizes.w16),
            child: Row(
              children: [
                const Icon(Icons.camera_alt),
                 SizedBox(width: AppSizes.w16),
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
            padding:  EdgeInsets.all(AppSizes.w16),
            child: Row(
              children: [
                const Icon(Icons.photo_library),
                 SizedBox(width: AppSizes.w16),
                Text("Gallery", style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
        ],
      );
    },
  );
}
