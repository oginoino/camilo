import '../../common_libs.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    const double cardElevation = 0.0;
    const double cardTextBoxHeight = 100;

    return Card(
      color: Theme.of(context).colorScheme.background,
      elevation: cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(uiConstants.paddingMedium),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(uiConstants.paddingMedium),
                    topRight: Radius.circular(uiConstants.paddingMedium),
                  ),
                ),
                width: uiConstants.squareImageSizeMedium,
                height: uiConstants.squareImageSizeMedium,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(uiConstants.paddingMedium),
                    topRight: Radius.circular(uiConstants.paddingMedium),
                  ),
                  child: Image.network(
                    widget.product.productImageSrc!,
                    cacheHeight: 420,
                    cacheWidth: 420,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.shopping_bag_rounded,
                          size: uiConstants.iconSizeLarge,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.surface,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: cardTextBoxHeight,
                width: uiConstants.squareImageSizeMedium,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: uiConstants.paddingSmall),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.product.productUnitQuantity,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          SizedBox(width: uiConstants.paddingExtraSmall),
                          Text(
                            widget.product.productUnitOfMeasurement,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                        child: Text(
                          widget.product.productName,
                          style: Theme.of(context).textTheme.labelMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          semanticsLabel: widget.product.productName,
                        ),
                      ),
                      Text(
                        'R\$ ${widget.product.productPrice.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          AddProductIcon(
            product: widget.product,
            updateProductSelectedQuantity: updateProductSelectedQuantity,
            productSelectedQuantity: widget.product.selectedQuantity,
          ),
        ],
      ),
    );
  }

  void updateProductSelectedQuantity({required bool isIncrement}) {
    if (isIncrement) {
      Provider.of<ProductCart>(context, listen: false)
          .addProduct(widget.product);
      widget.product.incrementSelectedQuantity(context);
      Provider.of<ProductList>(context, listen: false)
          .updateProduct(widget.product);
    } else {
      Provider.of<ProductCart>(context, listen: false)
          .removeProduct(widget.product);
      widget.product.decrementSelectedQuantity(context);
      Provider.of<ProductList>(context, listen: false)
          .updateProduct(widget.product);
    } // This will refresh the main icon state
  }
}
