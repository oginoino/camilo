import 'package:camilo/common_libs.dart';

Color _primaryLight = const Color(0xFF007F5F);
Color _primaryContainerLight = const Color(0xFF32DE8A);
Color _secondaryLight = const Color(0xFF2A9D8F);
Color _secondaryContainerLight = const Color(0xFFA2E8DD);
Color _backgroundLight = const Color(0xFFF7F7FF);
Color _onPrimaryLight = const Color(0xFFF7F7FF);
Color _onSecondaryLight = const Color(0xFFF7F7FF);
Color _tertiaryLight = const Color(0xFF264653);
Color _onBackgroundLight = const Color(0xFF052018);
Color _errorLight = const Color(0xFFE76F51);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryLight,
    primary: _primaryLight,
    primaryContainer: _primaryContainerLight,
    onPrimary: _onPrimaryLight,
    secondary: _secondaryLight,
    secondaryContainer: _secondaryContainerLight,
    onSecondary: _onSecondaryLight,
    tertiary: _tertiaryLight,
    background: _backgroundLight,
    onBackground: _onBackgroundLight,
    error: _errorLight,
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
    color: _backgroundLight,
    centerTitle: true,
    elevation: 2,
    titleTextStyle: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: _secondaryLight,
    foregroundColor: _onPrimaryLight,
  ),
);
