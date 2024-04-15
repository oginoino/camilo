import '../../common_libs.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductCart>(builder: (context, cart, child) {
      double deviceHeight = MediaQuery.of(context).size.height;

      return CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Seu carrinho'),
            leading: BackButton(
              style: ButtonStyle(),
            ),
          ),
          SliverList.list(
            children: [
              cart.products.products.isEmpty
                  ? SizedBox(
                      height: deviceHeight * 0.5,
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
                                  product.decrementSelectedQuantity(context);
                                  Provider.of<ProductList>(context,
                                          listen: false)
                                      .updateProduct(product);
                                },
                              ),
                            );
                          },
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text('Total'),
                          subtitle:
                              Text('R\$ ${cart.totalPrice.toStringAsFixed(2)}'),
                        ),
                        Consumer<ProductList>(
                            builder: (context, products, child) {
                          return ElevatedButton(
                            onPressed: () {
                              Provider.of<ProductCart>(context, listen: false)
                                  .clearProducts();
                              for (final product in products.products) {
                                Provider.of<ProductList>(context, listen: false)
                                    .clearProductSelectedQuantity(product);
                              }
                            },
                            child: const Text('Limpar carrinho'),
                          );
                        }),
                      ],
                    ),
            ],
          ),
        ],
      );
    });
  }
}
