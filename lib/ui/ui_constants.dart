import '../common_libs.dart';

class UiConstants {
  // seed colors
  Map<String, Color> get seedColors => {
        'primaryLight': const Color(0xFF007F5F),
        'primaryContainerLight': const Color(0xFF32DE8A),
        'secondaryLight': const Color(0xFF2A9D8F),
        'secondaryContainerLight': const Color(0xFFA2E8DD),
        'backgroundLight': const Color(0xFFF7F7FF),
        'onPrimaryLight': const Color(0xFFF7F7FF),
        'onSecondaryLight': const Color(0xFFF7F7FF),
        'tertiaryLight': const Color(0xFF264653),
        'onBackgroundLight': const Color(0xFF052018),
        'errorLight': const Color(0xFFE76F51),
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
}
