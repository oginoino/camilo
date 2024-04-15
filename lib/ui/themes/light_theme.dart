import 'package:camilo/common_libs.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: uiConstants.seedColors['primaryLight']!,
    primary: uiConstants.seedColors['primaryLight'],
    primaryContainer: uiConstants.seedColors['primaryContainerLight'],
    onPrimary: uiConstants.seedColors['onPrimaryLight'],
    secondary: uiConstants.seedColors['secondaryLight'],
    secondaryContainer: uiConstants.seedColors['secondaryContainerLight'],
    onSecondary: uiConstants.seedColors['onSecondaryLight'],
    tertiary: uiConstants.seedColors['tertiaryLight'],
    background: uiConstants.seedColors['backgroundLight'],
    onBackground: uiConstants.seedColors['onBackgroundLight'],
    error: uiConstants.seedColors['errorLight'],
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w300,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    displayMedium: TextStyle(
      fontSize: 38,
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    headlineMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    titleLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    titleMedium: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w500,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    titleSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    bodyLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    bodyMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    bodySmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
  ),
  appBarTheme: AppBarTheme(
    color: uiConstants.seedColors['backgroundLight'],
    centerTitle: true,
    elevation: 2,
    titleTextStyle: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: uiConstants.seedColors['secondaryLight']!,
    foregroundColor: uiConstants.seedColors['onSecondaryLight']!,
  ),
);
