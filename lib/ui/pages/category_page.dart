import '../../common_libs.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomAppBar(),
          const CustomBackButton(),
          _buildBodyTitle(context),
          _buildPageBody(),
        ],
      ),
      floatingActionButton: const SizedBox(),
      extendBody: true,
      resizeToAvoidBottomInset: false,
      primary: true,
      key: const Key('category_page'),
      restorationId: 'category',
      drawer: const CustomDrawer(),
    );
  }

  Consumer<ProductList> _buildPageBody() {
    return Consumer<ProductList>(
      builder: (context, products, child) {
        final productsFromCategory = products.products
            .where(
                (product) => product.productCategories.contains(categoryName))
            .toList();
        if (products.products.isNotEmpty) {
          return SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: uiConstants.paddingSmall,
            ),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 0,
                crossAxisSpacing: uiConstants.paddingSmall,
                childAspectRatio: 0.5,
                mainAxisExtent: 300,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ProductCard(product: productsFromCategory[index]);
                },
                childCount: productsFromCategory.length,
              ),
            ),
          );
        } else {
          return SliverFillRemaining(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off_rounded,
                      size: 100,
                      color: uiConstants.primaryLight,
                    ),
                    const Text(
                      'Nenhum produto foi encontrado para o termo digitado na categoria selecionada.',
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        products.getAllProducts();
                      },
                      child: const Text('Ver tudo'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  SliverToBoxAdapter _buildBodyTitle(BuildContext context) {
    final String categoryTitle = 'Tudo em $categoryName';
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
              categoryTitle,
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
