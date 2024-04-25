import '../../common_libs.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomAppBar(),
        const CustomBackButton(),
        _buildBodyTitle(context),
        _buildPageBody(),
      ],
    );
  }

  Consumer<ProductList> _buildPageBody() {
    return Consumer<ProductList>(
      builder: (context, products, child) {
        final productsFromCategory = products.products
            .where(
                (product) => product.productCategories.contains(categoryName))
            .toList();
        return SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: uiConstants.paddingSmall,
          ),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: uiConstants.paddingSmall,
              childAspectRatio: 0.5,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ProductCard(product: productsFromCategory[index]);
              },
              childCount: productsFromCategory.length,
            ),
          ),
        );
      },
    );
  }

  SliverToBoxAdapter _buildBodyTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: uiConstants.paddingSmall,
              top: uiConstants.paddingMedium,
            ),
            child: Text(
              categoryName,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: uiConstants.cyanGreen,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
