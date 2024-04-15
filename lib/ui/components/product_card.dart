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
    double contaninerWidth = 160.0;
    double contaninerHeght = 160.0;
    double cardElevation = 0.0;

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
                width: contaninerWidth,
                height: contaninerHeght,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(uiConstants.paddingMedium),
                    topRight: Radius.circular(uiConstants.paddingMedium),
                  ),
                  child: Image.network(
                    widget.product.productImageSrc!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: contaninerWidth,
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
          ),
        ],
      ),
    );
  }

  void updateProductSelectedQuantity({required bool isIncrement}) {
    if (isIncrement) {
      widget.product.incrementQuantity();
    } else {
      widget.product.decrementQuantity();
    }
    setState(() {}); // This will refresh the main icon state
  }
}
