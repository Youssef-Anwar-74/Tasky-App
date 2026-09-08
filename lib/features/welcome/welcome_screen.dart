import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/services/preferences_manager.dart';
import 'package:tasky_app/core/widgets/custom_text_form_field.dart';
import 'package:tasky_app/features/home/home_screen.dart';
import 'package:tasky_app/core/widgets/custom_svg_picture.dart';

import '../navigation/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppSizes.h16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSvgPicture.withoutColor(path: 'assets/images/tasky_logo.svg',),
                    SizedBox(width: AppSizes.w16),
                    Text(
                      "Tasky",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.ph100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome To Tasky",
                      style: Theme.of(context).textTheme.displaySmall
                    ),
                    SizedBox(width: AppSizes.w8),
                    CustomSvgPicture.withoutColor(path:"assets/images/waving_hand.svg"),
                  ],
                ),
                SizedBox(height: AppSizes.h8),
                Text(
                  "Your productivity journey starts here.",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: AppSizes.sp16
                  )
                ),
                SizedBox(height: AppSizes.ph24),
                CustomSvgPicture.withoutColor(
                  path: "assets/images/welcome.svg",
                  width: AppSizes.w200,
                  height: AppSizes.h200,
                )
                ,
                SizedBox(height: AppSizes.h28),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: AppSizes.h16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSizes.h8),
                      CustomTextFormField(
                        controller: controller,
                        hintText: "e.g. Youssef Anwar",
                        title: "Full Name",
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter Your Full Name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSizes.h24),
                      ElevatedButton(
                        onPressed: () async {
                          if (_key.currentState?.validate() ?? false) {
                            await PreferencesManager().setString(StorageKey.username, controller.value.text);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return MainScreen();
                                },
                              ),
                            );
                          } else {
                            // todo : snack bar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                  elevation: 0.2,
                                  content: Text(
                                      "Please Enter Your Full Name",
                                    style: GoogleFonts.aclonica(),
                                  )
                              )
                            );
                          }
                        },
                        child: Text(
                          "Let’s Get Started",
                          style: GoogleFonts.aclonica(
                            color: Color(0xFFFFFCFC),
                            fontSize: AppSizes.sp16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
