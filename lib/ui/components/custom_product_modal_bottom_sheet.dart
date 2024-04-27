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
        Center(
          child: Text(
            'Product details',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}
