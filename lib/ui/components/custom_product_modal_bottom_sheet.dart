import '../../common_libs.dart';

class CustomProductModalBottomSheet extends StatelessWidget {
  const CustomProductModalBottomSheet({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                width: 360,
                color: Theme.of(context).colorScheme.background,
                child:
                    Image.network(product.productImageSrc!, fit: BoxFit.contain,
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
              AddProductIcon(
                product: product,
              ),
            ],
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: uiConstants.paddingMedium,
                  ),
                  Center(
                    child: Container(
                      height: 64,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Consumer<ProductCart>(
                          builder: (context, productCart, child) {
                        int selectedQuantityByProductId = productCart
                            .getSelectedQuantityByProductId(product.id);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: UiConstants().paddingSmall),
                              child: IconButton(
                                  tooltip: 'Remover',
                                  onPressed: () {
                                    if (selectedQuantityByProductId > 0) {
                                      productCart.decrementProduct(
                                          context, product);
                                    }
                                  },
                                  iconSize: uiConstants.iconSizeMedium,
                                  icon: Icon(
                                    selectedQuantityByProductId < 1
                                        ? null
                                        : selectedQuantityByProductId == 1
                                            ? Icons.delete
                                            : Icons.remove_rounded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  )),
                            ),
                            Text(
                              selectedQuantityByProductId.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: UiConstants().paddingSmall),
                              child: IconButton(
                                tooltip: 'Adicionar',
                                onPressed: () {
                                  productCart.incrementProduct(
                                      context, product);
                                },
                                iconSize: uiConstants.iconSizeMedium,
                                icon: Row(
                                  children: [
                                    
                                    Icon(
                                      Icons.add_rounded,
                                      color: product.availableQuantity <=
                                              selectedQuantityByProductId
                                          ? Colors.transparent
                                          : Theme.of(context)
                                              .colorScheme
                                              .background,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
