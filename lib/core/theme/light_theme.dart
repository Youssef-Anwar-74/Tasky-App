import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      iconTheme: IconThemeData(color: Color(0xFF161F18)),
      centerTitle: false,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Color(0xFF15B86C)),
            foregroundColor:  WidgetStateProperty.all(Color(0xFFFFFCFC)),
            textStyle: WidgetStateProperty.all(
                GoogleFonts.aclonica(
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                )
            )
        )
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF15886C),
        foregroundColor: Color(0xFFFFFCFC),
        extendedTextStyle: GoogleFonts.aclonica(
            fontSize: 14,
            fontWeight: FontWeight.w500
        )
    ),

    textTheme: TextTheme(
      displaySmall: GoogleFonts.aclonica(
        fontSize: 24,
        color: Color(0xFF161F18),
      ),
        displayMedium: GoogleFonts.aclonica(
          fontSize: 28,
          color: Color(0xFF161F18),
        ),
        displayLarge: GoogleFonts.aclonica(
            fontSize: 32,
            color: Color(0xFF161F18),
            fontWeight: FontWeight.w400
        ),
        labelSmall: GoogleFonts.aclonica(
          color: Color(0xFF161F1B),
          fontSize: 20,
          fontWeight: FontWeight.w400
        ),
        labelMedium: GoogleFonts.aclonica(
            color: Colors.black,
          fontSize: 16
        ),
        labelLarge: GoogleFonts.aclonica(
            color: Colors.black,
            fontSize: 24
        ),
        titleSmall: GoogleFonts.aclonica(
            color: Color(0xFF3A4640),
            fontSize: 14,
            fontWeight: FontWeight.w400
        ),
        titleMedium: GoogleFonts.aclonica(
            color: Color(0xFF161F18),
            fontSize: 16,
            fontWeight: FontWeight.w400
        ),
        titleLarge: GoogleFonts.aclonica(
          color: Color(0xFFA0A0A0),
          fontSize: 16,
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
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Color(0xFFD1DAD6),
        ),
      ),
      focusColor: Color(0xFFD1DAD6),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
              color: Colors.red,
              width: 0.5
          ),),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Color(0xFFD1DAD6),
          width: 0.5
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Color(0xFFD1DAD6),
          width: 0.5
        ),
      ),
    ),

  checkboxTheme: CheckboxThemeData(
    side: BorderSide(
      color: Color(0xFFD1DAD6),
      width: 2
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4)
    )
  ),
  iconTheme: IconThemeData(
    color: Color(0xFF161F1B)
  ),

  listTileTheme: ListTileThemeData(
      titleTextStyle: GoogleFonts.aclonica(
          color: Color(0xFF161F18),
          fontSize: 16,
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
          fontSize: 14,
          fontWeight: FontWeight.bold
      ),
        unselectedLabelStyle: GoogleFonts.aclonica(
          fontSize: 12,
        )
    ),
  splashFactory: NoSplash.splashFactory,

  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFFF6F7F9),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(
          color: Color(0xFF15886C),
          width: 1
      ),
    ),
    elevation: 10,
    shadowColor: Color(0xFF15886C),
    labelTextStyle: WidgetStateProperty.all(
      GoogleFonts.aclonica(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        color: Colors.black
      ),
    ),
  ),

);
// 0xFF161F18