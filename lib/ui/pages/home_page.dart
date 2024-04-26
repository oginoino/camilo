import '../../common_libs.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomAppBar(),
        _buildSliverTopBoxAdapter(context),
        _buildPageBody(context),
      ],
    );
  }

  CustomTopBoxAdapter _buildSliverTopBoxAdapter(BuildContext context) {
    return const CustomTopBoxAdapter();
  }

  SliverList _buildPageBody(
    BuildContext context,
  ) {
    return SliverList.list(
      children: [
        Consumer<ProductList>(builder: (context, products, child) {
          List<String> productCategories = products.products
              .map((product) => product.productCategories)
              .expand((element) => element)
              .toSet()
              .toList();
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: uiConstants.paddingSmall,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: productCategories.length,
              itemBuilder: (context, index) {
                return ProductCarossel(
                    category: productCategories[index], products: products);
              },
            ),
          );
        })
      ],
    );
  }
}
