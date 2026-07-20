import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.maxLines,
    required this.hintText,
    this.validator,
    required this.title,
  });

  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final Function(String?)? validator;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: GoogleFonts.aclonica(color: Color(0xFFFFFCFC), fontSize: 16),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: Theme.of(context).textTheme.labelMedium,
          maxLines: maxLines,
          validator: validator != null
              ? (String? value) => validator!(value)
              : null,
          decoration: InputDecoration(hintText: hintText),

        ),
      ],
    );
  }
}
