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
            'Faltam ${(cart.minimumOrder - cart.totalPrice).toStringAsFixed(2)} para completar o pedido mínimo';
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
                  title: cart.products.products.isEmpty
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
                                    .clearProducts();

                                Provider.of<ProductList>(context, listen: false)
                                    .clearProductSelectedQuantity();
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
                  cart.products.products.isEmpty
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
                                SizedBox(height: uiConstants.paddingMedium),
                                FilledButton.icon(
                                  onPressed: () =>
                                      appRouter.go(ScreenPaths.home),
                                  label: const Text(
                                    voidCartButtonText,
                                  ),
                                  icon: Icon(
                                    Icons.add_shopping_cart_rounded,
                                    size: uiConstants.iconSizeSmall,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            cart.isMinimumOrder
                                ? const SizedBox()
                                : Padding(
                                    padding: EdgeInsets.all(
                                        uiConstants.paddingMedium),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.warning_rounded,
                                          size: uiConstants.iconSizeMedium,
                                          color: uiConstants.yellowSubmarine,
                                        ),
                                        SizedBox(
                                            width: uiConstants.paddingSmall),
                                        Text(
                                          notMinimumOrderMessage,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cart.productsGruppedByProductId.length,
                              itemBuilder: (context, index) {
                                final productGroup =
                                    cart.productsGruppedByProductId[index];
                                return ListTile(
                                  leading: SizedBox(
                                    width: uiConstants.squareImageSizeSmall,
                                    height: uiConstants.squareImageSizeSmall,
                                    child: Image.network(
                                      productGroup
                                              .products.first.productImageSrc ??
                                          '',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  visualDensity: VisualDensity.compact,
                                  isThreeLine: true,
                                  title: Text(
                                    productGroup.products.first.productName,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    semanticsLabel:
                                        productGroup.products.first.productName,
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
                                          '${productGroup.products.length} ${productGroup.products.first.productUnitOfMeasurement} por R\$ ${productGroup.products.first.productPrice.toStringAsFixed(2)}',
                                          overflow: TextOverflow.fade,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                        Text(
                                          'R\$ ${(productGroup.products.first.productPrice * productGroup.products.length).toStringAsFixed(2)}',
                                          overflow: TextOverflow.fade,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      Provider.of<ProductCart>(context,
                                              listen: false)
                                          .removeProduct(
                                              productGroup.products.last);
                                      productGroup.products.last
                                          .decrementSelectedQuantity(context);
                                      Provider.of<ProductList>(context,
                                              listen: false)
                                          .updateProduct(
                                              productGroup.products.last);
                                    },
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
                            FilledButton.icon(
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
                                    : Theme.of(context).colorScheme.background,
                                size: uiConstants.iconSizeSmall,
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
