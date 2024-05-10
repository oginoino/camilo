import '../common_libs.dart';

class CategorySelection extends ChangeNotifier {
  String _selectedCategory = 'Tudo';

  String get selectedCategory => _selectedCategory;

  void selectCategory(String category) {
    _selectedCategory = category;
    if (category == 'Tudo') {
      appRouter.go(ScreenPaths.home);
    } else {
      appRouter.go(ScreenPaths.categoryPath(category));
    }
    notifyListeners();
  }
}
