import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color bgColor = Color(0xffF5F5F5);
  static const Color surfaceColor = Color(0xffFFFFFF);
  static const Color borderColor = Color(0xffF0F0F0);
  static const Color textSecondary = Color(0xff737373);
  static const Color textPrimary = Color(0xff131212);
  static ThemeData get lightTheme {
    final ThemeData base = ThemeData.light();

    final workSansTheme = GoogleFonts.workSansTextTheme(
      base.textTheme,
    ).apply(bodyColor: textPrimary, displayColor: textPrimary);

    final textTheme = workSansTheme.copyWith(
      displayLarge: GoogleFonts.newsreader(
        fontSize: 40,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        height: 1.1,
        letterSpacing: -1.2,
        color: textPrimary,
      ),
      displayMedium: GoogleFonts.newsreader(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        height: 1.1,
        letterSpacing: -1.1,
        color: textPrimary,
      ),
      displaySmall: GoogleFonts.newsreader(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        height: 1.1,
        letterSpacing: -1,
        color: textPrimary,
      ),
      headlineLarge: GoogleFonts.newsreader(
        textStyle: workSansTheme.headlineLarge,
      ),
      headlineMedium: GoogleFonts.newsreader(
        textStyle: workSansTheme.headlineMedium,
      ),
      headlineSmall: GoogleFonts.newsreader(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        height: 1.2,
        letterSpacing: -0.72,
        color: textPrimary,
      ),

      titleLarge: GoogleFonts.caveat(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: textSecondary,
      ),
      titleMedium: GoogleFonts.workSans(
        color: bgColor,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      titleSmall: GoogleFonts.workSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xff999999),
        height: 1.4,
        letterSpacing: 0.96,
      ),
      bodyMedium: GoogleFonts.workSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        height: 1.3,
        letterSpacing: -0.64,
      ),
      bodySmall: workSansTheme.bodySmall?.copyWith(color: textSecondary),
      labelLarge: workSansTheme.labelLarge?.copyWith(
        color: textSecondary,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: workSansTheme.labelMedium?.copyWith(color: textSecondary),
      labelSmall: workSansTheme.labelSmall?.copyWith(color: textSecondary),
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: bgColor,
      colorScheme: ColorScheme.light(
        primary: bgColor,
        surface: surfaceColor,
        onSurface: textPrimary,
        outline: borderColor,
        outlineVariant: borderColor,
      ),
      textTheme: textTheme,
      dividerTheme: const DividerThemeData(
        color: borderColor,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
