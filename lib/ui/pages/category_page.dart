import '../../common_libs.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomAppBar(),
        SliverGridBody(
          categoryName: categoryName,
        ),
      ],
    );
  }
}

class SliverGridBody extends StatelessWidget {
  const SliverGridBody({
    super.key,
    required this.categoryName,
  });

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductList>(builder: (context, products, child) {
      final productsFromCategory = products.products
          .where((product) => product.productCategories.contains(categoryName))
          .toList();
      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ProductCard(product: productsFromCategory[index]);
          },
          childCount: productsFromCategory.length,
        ),
      );
    });
  }
}
