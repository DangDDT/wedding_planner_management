import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoreTheme {
  static const Color _color = Color.fromARGB(255, 175, 114, 10);
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _color,
          primary: _color,
        ),
        textTheme: GoogleFonts.arsenalTextTheme()
          ..apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xfff59e0b),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.arsenalTextTheme(),
        cardTheme: const CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
      );
}
