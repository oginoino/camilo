import '../../common_libs.dart';

class CartSummary extends StatefulWidget {
  const CartSummary({super.key});

  @override
  CartSummaryState createState() => CartSummaryState();
}

class CartSummaryState extends State<CartSummary> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return _buildCartSummary(context);
  }

  Widget _buildCartSummary(BuildContext context) {
    return Consumer<ProductCart>(builder: (
      context,
      productCart,
      child,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: uiConstants.paddingLarge),
          Text(
            'Resumo do carrinho',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: uiConstants.paddingLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Valor dos produtos',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'R\$ ${productCart.totalPrice.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          ExpansionPanelList(
            elevation: 0,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            expandIconColor: Theme.of(context).colorScheme.secondary,
            materialGapSize: 0.0,
            expandedHeaderPadding: EdgeInsets.zero,
            children: [
              ExpansionPanel(
                backgroundColor: Theme.of(context).colorScheme.background,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.shopping_basket_rounded,
                      size: uiConstants.iconRadiusLarge,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    title: Text(
                      'Sua sacola',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                  );
                },
                body: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: productCart.productsGruppedByProductId.length,
                  itemBuilder: (context, index) {
                    final item =
                        productCart.productsGruppedByProductId[index].first;
                    return ListTile(
                      minVerticalPadding: 0.0,
                      contentPadding: EdgeInsets.zero,
                      leading: SizedBox(
                        width: uiConstants.squareImageSizeExtraSmall,
                        height: uiConstants.squareImageSizeExtraSmall,
                        child: Image.network(
                          cacheWidth: 40,
                          cacheHeight: 40,
                          item.productImageSrc!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.shopping_bag_rounded,
                                size: uiConstants.iconSizeSmall,
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
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      title: Text(
                        item.productName,
                        style: Theme.of(context)
                            .listTileTheme
                            .titleTextStyle
                            ?.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(
                        '${productCart.productsGruppedByProductId[index].length} ${productCart.productsGruppedByProductId[index].first.productUnitOfMeasurement} por R\$ ${productCart.productsGruppedByProductId[index].first.productPrice.toStringAsFixed(2)}',
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: uiConstants.paddingMedium,
                          ),
                          Text(
                            'R\$ ${(item.productPrice * productCart.productsGruppedByProductId[index].length).toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                isExpanded: _isExpanded,
              ),
            ],
          ),
        ],
      );
    });
  }
}
