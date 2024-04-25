import '../../common_libs.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        CustomAppBar(),
      ],
    );
  }
}
