import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSvgPicture.withoutColor(path: 'assets/images/tasky_logo.svg',),
                    SizedBox(width: 16),
                    Text(
                      "Tasky",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(height: 118),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome To Tasky",
                      style: Theme.of(context).textTheme.displaySmall
                    ),
                    SizedBox(width: 8),
                    CustomSvgPicture.withoutColor(path:" assets/images/waving_hand.svg"),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "Your productivity journey starts here.",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 16
                  )
                ),
                SizedBox(height: 24),
                CustomSvgPicture.withoutColor(
                  path: "assets/images/welcome.svg",
                  width: 215,
                  height: 200,
                )
                ,
                SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
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
                      SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            48,
                          ),
                        ),
                        onPressed: () async {
                          if (_key.currentState?.validate() ?? false) {
                            await PreferencesManager().setString("username", controller.value.text);
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
                            fontSize: 16,
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
