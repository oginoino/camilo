import 'package:watch_it/watch_it.dart';

import '../../common_libs.dart';

class ProductCarossel extends StatelessWidget with WatchItMixin {
  const ProductCarossel({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    final productFromCategory = watchPropertyValue((ProductList p) {
      return p.products.where((product) {
        return product.productCategories.contains(category);
      }).toList();
    });

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
                  ...productFromCategory.map(
                    (product) => ProductCard(
                      product: product,
                    ),
                  ),
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
