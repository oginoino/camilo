import '../../common_libs.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: uiConstants.primaryLight,
    primary: uiConstants.primaryLight,
    primaryContainer: uiConstants.primaryContainerLight,
    onPrimary: uiConstants.onPrimaryLight,
    secondary: uiConstants.secondaryLight,
    secondaryContainer: uiConstants.secondaryContainerLight,
    onSecondary: uiConstants.onSecondaryLight,
    tertiary: uiConstants.tertiaryLight,
    surface: uiConstants.backgroundLight,
    onSurface: uiConstants.onBackgroundLight,
    error: uiConstants.errorLight,
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
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.nunito().fontFamily,
      color: uiConstants.primaryLight,
      letterSpacing: 1.25,
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
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    isDense: true,
    focusColor: uiConstants.secondaryLight,
    fillColor: uiConstants.backgroundLight,
    hoverColor: uiConstants.secondaryLight,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: uiConstants.primaryLight,
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: uiConstants.primaryLight,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: uiConstants.secondaryLight,
        width: 2,
      ),
    ),
    labelStyle: TextStyle(
      color: uiConstants.primaryLight,
      fontSize: 18,
      fontWeight: FontWeight.normal,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    hintStyle: TextStyle(
      color: uiConstants.tertiaryLight,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    errorStyle: TextStyle(
      color: uiConstants.errorLight,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    helperStyle: TextStyle(
      color: uiConstants.secondaryLight,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
    prefixStyle: TextStyle(
      color: uiConstants.primaryLight,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all<double>(1),
      fixedSize: WidgetStateProperty.all<Size>(const Size.fromHeight(56)),
      maximumSize: WidgetStateProperty.all<Size>(const Size.fromHeight(56)),
      minimumSize: WidgetStateProperty.all<Size>(const Size.fromHeight(56)),
      backgroundColor: WidgetStateProperty.all<Color>(uiConstants.primaryLight),
      foregroundColor:
          WidgetStateProperty.all<Color>(uiConstants.onPrimaryLight),
      textStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.poppins().fontFamily,
            letterSpacing: 1.25),
      ),
    ),
  ),
  scaffoldBackgroundColor: uiConstants.backgroundLight,
  appBarTheme: AppBarTheme(
    color: uiConstants.backgroundLight,
    centerTitle: true,
    elevation: 2,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.nunito().fontFamily,
      color: uiConstants.tertiaryLight,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: uiConstants.secondaryLight,
    foregroundColor: uiConstants.onSecondaryLight,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: uiConstants.secondaryLight,
    contentTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.nunito().fontFamily,
      color: uiConstants.onSecondaryLight,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    dismissDirection: DismissDirection.horizontal,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 2,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: uiConstants.surfaceLight,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: uiConstants.backgroundLight,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    elevation: 2,
    modalBackgroundColor: uiConstants.backgroundLight,
    modalElevation: 2,
    surfaceTintColor: uiConstants.backgroundLight,
    dragHandleColor: uiConstants.secondaryLight,
    dragHandleSize: const Size(64, 4),
  ),
  drawerTheme: DrawerThemeData(
    elevation: 2,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
    ),
    backgroundColor: uiConstants.backgroundLight,
    surfaceTintColor: uiConstants.backgroundLight,
    width: 360,
  ),
  listTileTheme: ListTileThemeData(
    tileColor: uiConstants.backgroundLight,
    selectedTileColor: uiConstants.primaryLight,
    iconColor: uiConstants.primaryLight,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.nunito().fontFamily,
      color: uiConstants.tertiaryLight,
      letterSpacing: 1.25,
    ),
    selectedColor: uiConstants.onPrimaryLight,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  searchBarTheme: SearchBarThemeData(
    elevation: WidgetStateProperty.all(2.0),
    backgroundColor: WidgetStateProperty.all(Colors.white),
    constraints: const BoxConstraints(
      minHeight: 48,
      maxHeight: 48,
      maxWidth: double.infinity,
      minWidth: double.infinity,
    ),
    textStyle: WidgetStateProperty.all(
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontFamily: GoogleFonts.nunito().fontFamily,
      ),
    ),
  ),
  expansionTileTheme: ExpansionTileThemeData(
    iconColor: uiConstants.primaryLight,
    backgroundColor: uiConstants.backgroundLight,
    collapsedBackgroundColor: uiConstants.backgroundLight,
    textColor: uiConstants.tertiaryLight,
    collapsedTextColor: uiConstants.tertiaryLight,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
);
