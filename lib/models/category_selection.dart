import '../common_libs.dart';

class CategorySelection extends ChangeNotifier {
  String _selectedCategory = 'Tudo';
  double _scrollPosition = 0.0;

  String get selectedCategory => _selectedCategory;
  double get scrollPosition => _scrollPosition;

  void selectCategory(String category) {
    _selectedCategory = category;
    if (category == 'Tudo') {
      appRouter.go(ScreenPaths.home);
    } else {
      appRouter.go(ScreenPaths.categoryPath(category));
    }
    notifyListeners();
  }

  void setScrollPosition(double position) {
    _scrollPosition = position;
    notifyListeners();
  }
}
