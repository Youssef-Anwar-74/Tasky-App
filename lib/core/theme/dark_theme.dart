import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primaryContainer: Color(0xFF282828),
        secondary: Color(0xFFC6C6C6)
    ),
    scaffoldBackgroundColor: Color(0xFF181818),
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
      backgroundColor: Color(0xFF181818),
      titleTextStyle: GoogleFonts.aclonica(
        color: Color(0xFFFFFCFC),
        fontSize: AppSizes.sp20,
        fontWeight: FontWeight.w400,
      ),
      iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
      centerTitle: false,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: (Color(0xFF15B86C)),
          foregroundColor:  (Color(0xFFFFFCFC)),
          textStyle: (
            GoogleFonts.aclonica(
              fontSize:AppSizes.sp14,
              fontWeight: FontWeight.w500
            )
          ),
          minimumSize: Size.fromHeight(AppSizes.h40)
        )
    ),

  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: (Colors.white),
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
      color: Color(0xFFFFFCFC),
      fontWeight: FontWeight.w400
    ),
    displayMedium: GoogleFonts.aclonica(
      fontSize: AppSizes.sp28,
      color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w400
    ),
    displayLarge: GoogleFonts.aclonica(
      fontSize: AppSizes.sp30,
      color: Color(0xFFFFFCFC),
      fontWeight: FontWeight.w400
    ),
      labelSmall: GoogleFonts.aclonica(
          color: Color(0xFFFFFCFC),
          fontSize: AppSizes.sp20,
          fontWeight: FontWeight.w400
      ),

    labelMedium: GoogleFonts.aclonica(
      color: Colors.white,
      fontSize: AppSizes.sp16
    ) ,

      labelLarge: GoogleFonts.aclonica(
          color: Colors.white,
          fontSize: AppSizes.sp24
      ),

    titleSmall: GoogleFonts.aclonica(
        color: Color(0xFFC6C6C6),
        fontSize: AppSizes.sp14,
        fontWeight: FontWeight.w400
    ),

    titleMedium: GoogleFonts.aclonica(
      color: Color(0xFFFFFCFC),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400
    ),

    titleLarge: GoogleFonts.aclonica(
      color: Color(0xFFA0A0A0),
      fontSize: AppSizes.sp16,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFFA0A0A0),
      fontWeight: FontWeight.w400
      //overflow: TextOverflow.ellipsis,
    )
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.aclonica(color: Color(0xFF6D6D6D)),
    filled: true,
    fillColor: Color(0xFF282828),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r20),
      borderSide: BorderSide.none,
    ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.r16),
        borderSide: BorderSide(
            color: Colors.red,
            width: 0.5
        ),),
  ),

    checkboxTheme: CheckboxThemeData(
        side: BorderSide(
            color: Color(0xFF6E6E6E),
            width: AppSizes.w2
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r4)
        )
    ),

    iconTheme: IconThemeData(
        color: Color(0xFFFFFCFC)
    ),

    listTileTheme: ListTileThemeData(
        titleTextStyle: GoogleFonts.aclonica(
            color: Color(0xFFFFFCFC),
            fontSize: AppSizes.sp16,
            fontWeight: FontWeight.w400
        )
    ) ,
  dividerTheme: DividerThemeData(
    color: Color(0xFF6E6E6E),
    thickness: 1,
  ),

  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
      selectionColor: Colors.grey,
      selectionHandleColor: Colors.white
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF181818),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xFFC6C6C6),
    selectedItemColor: Color(0xFF15B86C),
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
    color: Color(0xFF181818),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      side: BorderSide(
        color: Color(0xFF15886C),
        width: 1
      ),
    ),
    elevation: 10,
    shadowColor: Color(0xFF15886C),
    labelTextStyle: WidgetStateProperty.all(
      GoogleFonts.aclonica(
        fontSize: AppSizes.sp15,
        fontWeight: FontWeight.w400
      ),
    ),
  ),
);