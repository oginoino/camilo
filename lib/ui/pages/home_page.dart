import 'package:provider/provider.dart';

import '../../common_libs.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductList>(builder: (context, products, child) {
      List<String> productCategories = products.products
          .map((product) => product.productCategories)
          .expand((element) => element)
          .toSet()
          .toList();

      return CustomScrollView(
        slivers: [
          const CustomAppBar(),
          _buildSliverTopBoxAdapter(context),
          _buildPageBody(context, productCategories),
        ],
      );
    });
  }

  SliverToBoxAdapter _buildSliverTopBoxAdapter(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_rounded,
                      size: uiConstants.iconSizeSmall,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    SizedBox(width: uiConstants.paddingExtraSmall),
                    Text(
                      'Mercado aberto agora!',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon(
                    //   Icons.shopping_bag_rounded,
                    //   size: uiConstants.iconSizeSmall,
                    //   color: Theme.of(context).colorScheme.tertiary,
                    // ),
                    // SizedBox(width: uiConstants.paddingExtraSmall),
                    Text(
                      'Entrega em até 30 minutos',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  SliverList _buildPageBody(
      BuildContext context, List<String> productCategories) {
    return SliverList.list(children: [
      Padding(
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
      )
    ]);
  }
}
