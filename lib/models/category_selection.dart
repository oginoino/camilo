import '../common_libs.dart';

class CategorySelection extends ChangeNotifier {
  String _selectedCategory = 'Tudo';

  String get selectedCategory => _selectedCategory;

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
