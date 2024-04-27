import '../../common_libs.dart';

class CustomProductModalBottomSheet extends StatelessWidget {
  const CustomProductModalBottomSheet({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 200,
          color: Theme.of(context).colorScheme.background,
          child: Image.network(product.productImageSrc!, fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                Icons.shopping_bag_rounded,
                size: uiConstants.iconSizeLarge,
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
          }, loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            }
          }),
        ),
        Padding(
          padding: EdgeInsets.all(uiConstants.paddingMedium),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: uiConstants.paddingExtraExtraLarge,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      product.productName,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(
                  height: uiConstants.paddingLarge,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Text(
                          product.productUnitQuantity,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(width: uiConstants.paddingExtraSmall),
                        Text(
                          product.productUnitOfMeasurement,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Spacer(),
                        Text(
                          '${product.contentValue}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: uiConstants.paddingMedium,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'R\$ ${product.productPrice.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
