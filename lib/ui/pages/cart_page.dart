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
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                  title: const Text('Seu carrinho'),
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
                                      Theme.of(context).colorScheme.primary.withOpacity(0.8),
                                ),
                                onPressed: () {
                                  Provider.of<ProductCart>(context,
                                          listen: false)
                                      .clearProducts();

                                  Provider.of<ProductList>(context,
                                          listen: false)
                                      .clearProductSelectedQuantity();
                                },
                                label: Text(
                                  'Limpar carrinho',
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
                  )),
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
                                const Text('Seu carrinho está vazio'),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            ListView.builder(
                              // never scrollable
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cart.products.products.length,
                              itemBuilder: (context, index) {
                                final product = cart.products.products[index];
                                return ListTile(
                                  isThreeLine: true,
                                  title: Text(product.productName),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                          '${product.productUnitQuantity} ${product.productUnitOfMeasurement} x R\$ ${product.productPrice.toStringAsFixed(2)} = '),
                                      Text(
                                          'R\$ ${product.productPrice.toStringAsFixed(2)}'),
                                    ],
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
                            const Divider(),
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
