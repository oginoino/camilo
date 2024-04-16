import '../common_libs.dart';

class UiConstants {
  // seed colors
  Map<String, Color> get seedColors => {
        'primaryLight': const Color(0xFF007F5F),
        'primaryContainerLight': const Color(0xFF32DE8A),
        'secondaryLight': const Color(0xFF2A9D8F),
        'secondaryContainerLight': const Color(0xFF8AC4B2),
        'backgroundLight': const Color(0xFFF7F7FF),
        'onPrimaryLight': const Color(0xFFF7F7FF),
        'onSecondaryLight': const Color(0xFFF7F7FF),
        'tertiaryLight': const Color(0xFF264653),
        'onBackgroundLight': const Color(0xFF052018),
        'errorLight': const Color(0xFFE76F51),
        'surfaceLight': const Color(0xFFABECD9),
      };

  // colors
  Color get yellowSubmarine => const Color(0xFFE9C46A);
  Color get cyanGreen => const Color(0xFF2A9D8F);
  Color get orangeLagrange => const Color(0xFFF4A261);
  Color get jeanGrey => const Color.fromARGB(255, 134, 173, 147);

  // padding
  double get paddingExtraSmall => 4.0;
  double get paddingSmall => 8.0;
  double get paddingMedium => 16.0;
  double get paddingLarge => 32.0;
  double get paddingExtraLarge => 64.0;

  // icon sizes
  double get iconSizeSmall => 16.0;
  double get iconSizeMedium => 24.0;
  double get iconSizeLarge => 32.0;
  double get iconSizeExtraLarge => 64.0;

  // border side width
  double get borderSideWidthMedium => 0.5;

  // divider height
  double get dividerHeightMedium => 1.0;

  // heights
  double get bottomNavigationBarHeight => 80.0;

  // image sizes
  double get squareImageSizeSmall => 60.0;
  double get squareImageSizeMedium => 160.0;
}
