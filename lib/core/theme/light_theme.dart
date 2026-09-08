import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_sizes.dart';

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        primaryContainer: Color(0xFFFFFFFF),
      secondary: Color(0xFF3A4640)
    ),
    scaffoldBackgroundColor: Color(0xFFF6F7F9),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Color(0xFF15B86C);
        }
        return Color(0xFF6E6E6E);
      }),
      thumbColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Color(0xFFFFFCFC);
        }
        return Color(0xFF9E9E9E);
      }),
      trackOutlineColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.transparent;
        }
        return Color(0xFF9E9E9E);
      }),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFF6F7F9),
      titleTextStyle: GoogleFonts.aclonica(
        color: Color(0xFF161F18),
        fontSize: AppSizes.sp20,
        fontWeight: FontWeight.w400,
      ),
      iconTheme: IconThemeData(color: Color(0xFF161F18)),
      centerTitle: false,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: (Color(0xFF15B86C)),
            foregroundColor:  (Color(0xFFFFFCFC)),
            textStyle: (
                GoogleFonts.aclonica(
                    fontSize: AppSizes.sp14,
                    fontWeight: FontWeight.w500
                )
            ),
            minimumSize: Size.fromHeight(AppSizes.h40)
        )
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: (Colors.black),
      )
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF15886C),
        foregroundColor: Color(0xFFFFFCFC),
        extendedTextStyle: GoogleFonts.aclonica(
            fontSize: AppSizes.sp14,
            fontWeight: FontWeight.w500
        )
    ),

    textTheme: TextTheme(
      displaySmall: GoogleFonts.aclonica(
        fontSize: AppSizes.sp24,
        color: Color(0xFF161F18),
      ),
        displayMedium: GoogleFonts.aclonica(
          fontSize: AppSizes.sp28,
          color: Color(0xFF161F18),
        ),
        displayLarge: GoogleFonts.aclonica(
            fontSize: AppSizes.sp30,
            color: Color(0xFF161F18),
            fontWeight: FontWeight.w400
        ),
        labelSmall: GoogleFonts.aclonica(
          color: Color(0xFF161F1B),
          fontSize: AppSizes.sp20,
          fontWeight: FontWeight.w400
        ),
        labelMedium: GoogleFonts.aclonica(
            color: Colors.black,
          fontSize: AppSizes.sp16
        ),
        labelLarge: GoogleFonts.aclonica(
            color: Colors.black,
            fontSize: AppSizes.sp24
        ),
        titleSmall: GoogleFonts.aclonica(
            color: Color(0xFF3A4640),
            fontSize: AppSizes.sp14,
            fontWeight: FontWeight.w400
        ),
        titleMedium: GoogleFonts.aclonica(
            color: Color(0xFF161F18),
            fontSize: AppSizes.sp16,
            fontWeight: FontWeight.w400
        ),
        titleLarge: GoogleFonts.aclonica(
          color: Color(0xFFA0A0A0),
          fontSize: AppSizes.sp16,
          decoration: TextDecoration.lineThrough,
          decorationColor: Color(0xFF6A6A6A),
            fontWeight: FontWeight.w400
          //overflow: TextOverflow.ellipsis,
        )
    ),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.aclonica(color: Color(0xFF9E9E9E)),
      filled: true,
      fillColor: Color(0xFFFFFFFF),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.r16),
        borderSide: BorderSide(
          color: Color(0xFFD1DAD6),
        ),
      ),
      focusColor: Color(0xFFD1DAD6),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r16),
          borderSide: BorderSide(
              color: Colors.red,
              width: AppSizes.w05
          ),),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.r16),
        borderSide: BorderSide(
          color: Color(0xFFD1DAD6),
          width: AppSizes.w05
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.r16),
        borderSide: BorderSide(
          color: Color(0xFFD1DAD6),
          width: AppSizes.w05
        ),
      ),
    ),

  checkboxTheme: CheckboxThemeData(
    side: BorderSide(
      color: Color(0xFFD1DAD6),
      width: AppSizes.w2
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r4)
    )
  ),
  iconTheme: IconThemeData(
    color: Color(0xFF161F1B)
  ),

  listTileTheme: ListTileThemeData(
      titleTextStyle: GoogleFonts.aclonica(
          color: Color(0xFF161F18),
          fontSize: AppSizes.sp16,
          fontWeight: FontWeight.w400
      )
  ),
    dividerTheme: DividerThemeData(
      color: Color(0xFFD1DAD6),
      thickness: 1,
    ),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black,
      selectionColor: Colors.grey,
      selectionHandleColor: Colors.black
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF6F7F9),
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Color(0xFF3A4640),
      selectedItemColor: Color(0xFF14A662),
      selectedLabelStyle: GoogleFonts.aclonica(
          fontSize: AppSizes.sp14,
          fontWeight: FontWeight.bold
      ),
        unselectedLabelStyle: GoogleFonts.aclonica(
          fontSize: AppSizes.sp12,
        )
    ),
  splashFactory: NoSplash.splashFactory,

  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFFF6F7F9),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      side: BorderSide(
          color: Color(0xFF15886C),
          width: AppSizes.w2
      ),
    ),
    elevation: 10,
    shadowColor: Color(0xFF15886C),
    labelTextStyle: WidgetStateProperty.all(
      GoogleFonts.aclonica(
          fontSize: AppSizes.sp15,
          fontWeight: FontWeight.w400,
        color: Colors.black
      ),
    ),
  ),

);
// 0xFF161F18