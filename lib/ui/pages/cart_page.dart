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
        const String endCardButtonText = 'Adicionar mais produtos';
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
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.8),
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
                                          .onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              icon: Icon(
                                Icons.remove_shopping_cart_rounded,
                                size: uiConstants.iconSizeSmall,
                                color: Theme.of(context).colorScheme.onPrimary,
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
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cart.products.products.length,
                              itemBuilder: (context, index) {
                                final product = cart.products.products[index];
                                return ListTile(
                                  leading: SizedBox(
                                    width: uiConstants.squareImageSizeSmall,
                                    height: uiConstants.squareImageSizeSmall,
                                    child: Image.network(
                                      product.productImageSrc ?? '',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  visualDensity: VisualDensity.compact,
                                  isThreeLine: true,
                                  title: Text(
                                    product.productName,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    semanticsLabel: product.productName,
                                  ),
                                  subtitle: SizedBox(
                                    width: 180,
                                    child: Row(
                                      children: [
                                        Text(
                                          '${product.productUnitQuantity} ${product.productUnitOfMeasurement} x R\$ ${product.productPrice.toStringAsFixed(2)} = ',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                        Text(
                                          'R\$ ${product.productPrice.toStringAsFixed(2)}',
                                          overflow: TextOverflow.ellipsis,
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
                                          .removeProduct(product);
                                      product
                                          .decrementSelectedQuantity(context);
                                      Provider.of<ProductList>(context,
                                              listen: false)
                                          .updateProduct(product);
                                    },
                                  ),
                                );
                              },
                            ),
                            Divider(
                              height: uiConstants.dividerHeightMedium,
                            ),
                            FilledButton.icon(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.background),
                              onPressed: () => appRouter.go(ScreenPaths.home),
                              label: Text(
                                endCardButtonText,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              icon: Icon(
                                Icons.add_shopping_cart_rounded,
                                color: Theme.of(context).colorScheme.primary,
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
