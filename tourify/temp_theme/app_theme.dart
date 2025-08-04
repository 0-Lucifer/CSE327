import 'package:flutter/material.dart';

class AppTheme {
  // Navy Blue Color Palette
  static const Color primaryNavy = Color(0xFF1A237E);
  static const Color secondaryNavy = Color(0xFF283593);
  static const Color lightNavy = Color(0xFF3F51B5);
  static const Color darkNavy = Color(0xFF0D1B69);
  
  // Glass Effect Colors
  static const Color glassWhite = Color(0x1AFFFFFF);
  static const Color glassBlue = Color(0x1A3F51B5);
  static const Color glassBorder = Color(0x33FFFFFF);
  
  // Accent Colors
  static const Color goldAccent = Color(0xFFFFD700);
  static const Color silverAccent = Color(0xFFC0C0C0);
  static const Color premiumWhite = Color(0xFFF8F9FA);

  static ThemeData get premiumTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryNavy,
        brightness: Brightness.light,
        primary: primaryNavy,
        secondary: secondaryNavy,
        surface: premiumWhite,
        background: const Color(0xFFF0F2F5),
      ),
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: primaryNavy,
        titleTextStyle: TextStyle(
          color: primaryNavy,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      
      // Card Theme
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.transparent,
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryNavy,
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: primaryNavy.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      
      // Text Theme
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: primaryNavy,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          color: primaryNavy,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
        titleLarge: TextStyle(
          color: primaryNavy,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: Color(0xFF2C3E50),
          fontSize: 16,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          color: Color(0xFF546E7A),
          fontSize: 14,
          height: 1.4,
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: glassWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: glassBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: glassBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryNavy, width: 2),
        ),
        labelStyle: const TextStyle(color: primaryNavy),
        hintStyle: TextStyle(color: primaryNavy.withOpacity(0.6)),
      ),
    );
  }

  static BoxDecoration get glassContainer {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          glassWhite,
          glassBlue,
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: glassBorder,
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: primaryNavy.withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  static BoxDecoration get premiumBackground {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFF8F9FA),
          Color(0xFFE3F2FD),
          Color(0xFFBBDEFB),
        ],
      ),
    );
  }

  static BoxDecoration get navyGradient {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          primaryNavy,
          secondaryNavy,
          lightNavy,
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: primaryNavy.withOpacity(0.3),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  static BoxDecoration get goldAccentGradient {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          goldAccent,
          goldAccent.withOpacity(0.8),
        ],
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: goldAccent.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}