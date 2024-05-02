import '../../common_libs.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double expandedTitleScale = 1.1;
    double collapsedHeight = 108.0;
    double expandedHeight = 100.0;

    return Consumer<ProductCart>(
      builder: (context, cart, child) {
        const String pageTitle = 'Seu carrinho';
        const String clearCartButtonText = 'Limpar carrinho';
        const String voidCartMessage = 'Seu carrinho está vazio';
        const String voidCartButtonText = 'Adicionar produtos';
        const String endCardButtonText = 'Adicionar outros produtos';
        const String endCardButtonIextNotMinimumOrder =
            'Adicionar mais produtos';
        var notMinimumOrderMessage =
            'Adicione mais R\$ ${(cart.minimumOrder - cart.totalPrice).toStringAsFixed(2)} para atingir o valor mínimo.';
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text(pageTitle),
                leading: const BackButton(
                  style: ButtonStyle(),
                ),
                floating: true,
                snap: true,
                pinned: false,
                forceElevated: false,
                expandedHeight: expandedHeight,
                collapsedHeight: collapsedHeight,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  collapseMode: CollapseMode.parallax,
                  expandedTitleScale: expandedTitleScale,
                  titlePadding: EdgeInsets.zero,
                  title: cart.cartProducts.isEmpty
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.all(uiConstants.paddingSmall),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                visualDensity: VisualDensity.comfortable,
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                                elevation: 0.0,
                              ),
                              onPressed: () {
                                Provider.of<ProductCart>(context, listen: false)
                                    .clearCart();
                              },
                              label: Text(
                                clearCartButtonText,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              icon: Icon(
                                Icons.remove_shopping_cart_rounded,
                                size: uiConstants.iconSizeSmall,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              SliverList.list(
                children: [
                  cart.cartProducts.isEmpty
                      ? SizedBox(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_basket_rounded,
                                  size: uiConstants.iconSizeExtraLarge,
                                  color: uiConstants.jeanGrey,
                                ),
                                const Text(voidCartMessage),
                                SizedBox(height: uiConstants.paddingExtraLarge),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: uiConstants.paddingLarge,
                                    vertical: uiConstants.paddingMedium,
                                  ),
                                  child: FilledButton.icon(
                                    onPressed: () =>
                                        appRouter.go(ScreenPaths.home),
                                    label: const Text(
                                      voidCartButtonText,
                                    ),
                                    icon: Icon(
                                      Icons.add_shopping_cart_rounded,
                                      size: uiConstants.iconSizeMedium,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            ListView.builder(
                              key: const PageStorageKey<String>('cart-items'),
                              addSemanticIndexes: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cart.productsGruppedByProductId.length,
                              itemBuilder: (context, index) {
                                final productGroup =
                                    cart.productsGruppedByProductId[index];
                                return ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: uiConstants.paddingSmall,
                                  ),
                                  minVerticalPadding: uiConstants.paddingSmall,
                                  leading: SizedBox(
                                    width: uiConstants.squareImageSizeSmall,
                                    height: uiConstants.squareImageSizeSmall,
                                    child: Image.network(
                                      cacheWidth: 126,
                                      cacheHeight: 126,
                                      productGroup.first.productImageSrc ?? '',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                          child: Icon(
                                            Icons.shopping_bag_rounded,
                                            size: uiConstants.iconSizeSmall,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        );
                                      },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  visualDensity: VisualDensity.compact,
                                  isThreeLine: true,
                                  title: Text(
                                    productGroup.first.productName,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    semanticsLabel:
                                        productGroup.first.productName,
                                  ),
                                  subtitle: SizedBox(
                                    width: 180,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${productGroup.length} ${productGroup.first.productUnitOfMeasurement} por R\$ ${productGroup.first.productPrice.toStringAsFixed(2)}',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                        Text(
                                          'R\$ ${(productGroup.first.productPrice * productGroup.length).toStringAsFixed(2)}',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        width: uiConstants.dividerHeightMedium,
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    width: 116,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                    EdgeInsetsGeometry>(
                                                EdgeInsets.zero),
                                            visualDensity:
                                                VisualDensity.compact,
                                          ),
                                          icon: Icon(
                                            productGroup.length == 1
                                                ? Icons.delete_rounded
                                                : Icons.remove_rounded,
                                          ),
                                          onPressed: () {
                                            Provider.of<ProductCart>(context,
                                                    listen: false)
                                                .decrementProduct(
                                                    context, productGroup.last);
                                          },
                                        ),
                                        Text(
                                          productGroup.length.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        IconButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                    EdgeInsetsGeometry>(
                                                EdgeInsets.zero),
                                            visualDensity:
                                                VisualDensity.compact,
                                          ),
                                          icon: const Icon(Icons.add_rounded),
                                          onPressed: () {
                                            Provider.of<ProductCart>(context,
                                                    listen: false)
                                                .incrementProduct(context,
                                                    productGroup.first);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            Divider(
                              height: uiConstants.dividerHeightMedium,
                            ),
                            SizedBox(
                              height: uiConstants.paddingSmall,
                            ),
                            cart.isMinimumOrder
                                ? const SizedBox()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.warning_rounded,
                                        size: uiConstants.iconSizeMedium,
                                        color: uiConstants.yellowSubmarine,
                                      ),
                                      SizedBox(width: uiConstants.paddingSmall),
                                      SizedBox(
                                        height: 56,
                                        width: 200,
                                        child: Center(
                                          child: Text(
                                            notMinimumOrderMessage,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: uiConstants.paddingLarge,
                                vertical: uiConstants.paddingMedium,
                              ),
                              child: FilledButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: cart.isMinimumOrder
                                      ? Theme.of(context).colorScheme.background
                                      : Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () => appRouter.go(ScreenPaths.home),
                                label: Text(
                                  cart.isMinimumOrder
                                      ? endCardButtonText
                                      : endCardButtonIextNotMinimumOrder,
                                  style: TextStyle(
                                    color: cart.isMinimumOrder
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .background,
                                  ),
                                ),
                                icon: Icon(
                                  Icons.add_shopping_cart_rounded,
                                  color: cart.isMinimumOrder
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .background,
                                  size: uiConstants.iconSizeMedium,
                                ),
                              ),
                            )
                          ],
                        ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: const CustomBottomNavigationBar(),
        );
      },
    );
  }
}
