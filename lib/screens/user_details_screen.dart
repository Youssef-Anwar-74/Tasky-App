import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/services/preferences_manager.dart';
import 'package:tasky_app/core/widgets/custom_text_form_field.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });

  final String userName;
  final String? motivationQuote;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController motivationQuoteController =
      TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameController.text = widget.userName;
    motivationQuoteController.text = widget.motivationQuote ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextFormField(
                controller: userNameController,
                title: "User Name",
                hintText: "Youssef Anwar",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter User Name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: motivationQuoteController,
                title: "Motivation Quote",
                hintText: "One task at a time. One step closer.",
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter User Name";
                  }
                  return null;
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    await PreferencesManager().setString("username", userNameController.value.text);
                    await PreferencesManager().setString("motivation_quote", motivationQuoteController.value.text);

                    Navigator.pop(context, true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                ),
                child: Text(
                  "Save Changes",
                  style: GoogleFonts.aclonica(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
