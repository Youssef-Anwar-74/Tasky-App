import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
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

  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.white),
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
      color: Color(0xFFFFFCFC),
      fontWeight: FontWeight.w400
    ),
    displayMedium: GoogleFonts.aclonica(
      fontSize: 28,
      color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w400
    ),
    displayLarge: GoogleFonts.aclonica(
      fontSize: 32,
      color: Color(0xFFFFFCFC),
      fontWeight: FontWeight.w400
    ),
      labelSmall: GoogleFonts.aclonica(
          color: Color(0xFFFFFCFC),
          fontSize: 20,
          fontWeight: FontWeight.w400
      ),

    labelMedium: GoogleFonts.aclonica(
      color: Colors.white,
      fontSize: 16
    ) ,

      labelLarge: GoogleFonts.aclonica(
          color: Colors.white,
          fontSize: 24
      ),

    titleSmall: GoogleFonts.aclonica(
        color: Color(0xFFC6C6C6),
        fontSize: 14,
        fontWeight: FontWeight.w400
    ),

    titleMedium: GoogleFonts.aclonica(
      color: Color(0xFFFFFCFC),
      fontSize: 16,
      fontWeight: FontWeight.w400
    ),

    titleLarge: GoogleFonts.aclonica(
      color: Color(0xFFA0A0A0),
      fontSize: 16,
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
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
            color: Colors.red,
            width: 0.5
        ),),
  ),

    checkboxTheme: CheckboxThemeData(
        side: BorderSide(
            color: Color(0xFF6E6E6E),
            width: 2
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
        )
    ),

    iconTheme: IconThemeData(
        color: Color(0xFFFFFCFC)
    ),

    listTileTheme: ListTileThemeData(
        titleTextStyle: GoogleFonts.aclonica(
            color: Color(0xFFFFFCFC),
            fontSize: 16,
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
        fontSize: 14,
        fontWeight: FontWeight.bold
    ),
      unselectedLabelStyle: GoogleFonts.aclonica(
        fontSize: 12,
      )
  ),
    splashFactory: NoSplash.splashFactory,

  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFF181818),
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
        fontWeight: FontWeight.w400
      ),
    ),
  ),
);