import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Predefined colors (unchanged)
  static const darkBlue = Color(0xFF180440);
  static const lightVioletBlue = Color(0xFF311b83);
  static const darkBlueAccent = Color(0xFF242c6c);
  static const white = Colors.white;
  static const grey = Color(0xFF757575);
  static const accent = Color(0xFF00C4B4);
  static const divider = Color(0xFFE0E0E0);
  static const lightGreen = Color(0xFFA5D6A7);
  static const lightYellow = Color(0xFFFFF59D);
  static const softOrange = Color(0xFFFFB74D);
  static const pastelPurple = Color(0xFFB39DDB);
  static const glassWhite = Color(0x22FFFFFF);

  // New colors from provided palette
  static const charcoal = Color(0xFF252422);
  static const oliveGreen = Color(0xFF648B20);
  static const goldenYellow = Color(0xFFC0A93F);
  static const lightCharcoal = Color(0xFF3A3937); // Lighter version of #252422
  static const lightOlive = Color(0xFF8BB33E); // Lighter version of #648B20
  static const lightGolden = Color(0xFFD8C270);
  static const lightOliveee = Color(0xFF95B685);// Lighter version of #C0A93F
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.transparent,
      shadowColor: Colors.black.withOpacity(0.2),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.poppins(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        labelMedium: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
          shadowColor: Colors.black.withOpacity(0.2),
        ),
      ),
      fontFamily: GoogleFonts.poppins().fontFamily,
    );
  }

  static BoxDecoration get buttonDecoration {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}