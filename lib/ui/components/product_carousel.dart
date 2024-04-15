import '../../common_libs.dart';

class ProductCarossel extends StatelessWidget {
  const ProductCarossel({
    super.key,
    required this.category,
    required this.products,
  });

  final String category;
  final ProductList products;

  @override
  Widget build(BuildContext context) {
    final productsFromCategory = products.products
        .where((product) => product.productCategories.contains(category))
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: uiConstants.cyanGreen,
              ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Row(
                children: [
                  ...productsFromCategory.map((product) {
                    return ProductCard(product: product);
                  }),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: uiConstants.paddingSmall),
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            const Text('Ver tudo'),
                            SizedBox(width: uiConstants.paddingExtraSmall),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: uiConstants.iconSizeSmall,
                              opticalSize: uiConstants.iconSizeSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
