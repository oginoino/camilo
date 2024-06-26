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
                color: Theme.of(context).colorScheme.surface,
                child:
                    Image.network(product.productImageSrc, fit: BoxFit.contain,
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
                iconSize: uiConstants.iconSizeXL,
                iconRadius: uiConstants.iconRadiusLarge,
                iconFontSize: uiConstants.iconSizeMedium,
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
                    height: uiConstants.paddingExtraLarge,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            '${product.productUnitQuantity} ${product.productUnitOfMeasure}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const Spacer(),
                          Text(
                            product.contentValue,
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
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
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: uiConstants.paddingExtraExtraLarge,
                  ),
                  Center(
                    child: Container(
                      height: uiConstants.paddingExtraExtraLarge,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(
                            uiConstants.borderRadiusLarge),
                      ),
                      child: Consumer<ProductCart>(
                          builder: (context, productCart, child) {
                        int selectedQuantityByProductId = productCart
                            .getSelectedQuantityByProductId(product.id);
                        const double bottomSheetButtonWidth = 132;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: bottomSheetButtonWidth,
                              ),
                              child: IconButton(
                                  tooltip: 'Remover',
                                  onPressed: () {
                                    if (selectedQuantityByProductId > 0) {
                                      productCart.decrementProduct(
                                          context, product, cartService);
                                    }
                                  },
                                  iconSize: uiConstants.iconSizeMedium,
                                  icon: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        selectedQuantityByProductId < 1
                                            ? null
                                            : selectedQuantityByProductId == 1
                                                ? Icons.delete_rounded
                                                : Icons.remove_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),
                                      SizedBox(
                                          width: uiConstants.paddingExtraSmall),
                                      Text(
                                        selectedQuantityByProductId < 1
                                            ? ''
                                            : selectedQuantityByProductId == 1
                                                ? 'Excluir'
                                                : 'Remover',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )),
                            ),
                            Container(
                              constraints: const BoxConstraints(
                                minWidth: 40,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(
                                    uiConstants.borderRadiusSmall),
                                shape: BoxShape.rectangle,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: UiConstants().paddingSmall,
                                vertical: UiConstants().paddingExtraSmall,
                              ),
                              child: Text(
                                selectedQuantityByProductId.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: bottomSheetButtonWidth,
                              ),
                              child: IconButton(
                                tooltip: 'Adicionar',
                                onPressed: () {
                                  productCart.incrementProduct(
                                      context, product, cartService);
                                },
                                iconSize: uiConstants.iconSizeMedium,
                                icon: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      product.availableQuantity <=
                                              selectedQuantityByProductId
                                          ? 'Máximo'
                                          : 'Adicionar',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                        width: uiConstants.paddingExtraSmall),
                                    product.availableQuantity <=
                                            selectedQuantityByProductId
                                        ? const SizedBox()
                                        : Icon(
                                            Icons.add_rounded,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
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
                  SizedBox(
                    height: uiConstants.paddingLarge,
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
