import '../../common_libs.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductCart>(
      builder: (context, cart, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _buildSliverAppBar(context, cart),
              _buildCartContent(context, cart),
            ],
          ),
          bottomNavigationBar: const CustomBottomNavigationBar(),
        );
      },
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context, ProductCart cart) {
    const double expandedTitleScale = 1.1;
    const double collapsedHeight = 108.0;
    const double expandedHeight = 100.0;
    return SliverAppBar(
      title: const Text('Seu carrinho'),
      leading: BackButton(
        onPressed: () {
          appRouter.go(ScreenPaths.home);
        },
      ),
      floating: true,
      snap: true,
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        collapseMode: CollapseMode.parallax,
        expandedTitleScale: expandedTitleScale,
        titlePadding: EdgeInsets.zero,
        title: cart.cartProducts.isEmpty
            ? const SizedBox()
            : _buildClearCartButton(context),
      ),
    );
  }

  Widget _buildClearCartButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(uiConstants.paddingSmall),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            visualDensity: VisualDensity.comfortable,
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 0.0,
          ),
          onPressed: () {
            Provider.of<ProductCart>(context, listen: false)
                .clearCart(cartService);
          },
          label: Text(
            'Limpar carrinho',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
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
    );
  }

  SliverList _buildCartContent(BuildContext context, ProductCart cart) {
    return SliverList(
      delegate: SliverChildListDelegate(
        cart.cartProducts.isEmpty
            ? [_buildEmptyCart(context)]
            : _buildCartItems(context, cart),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return SizedBox(
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
            SizedBox(height: uiConstants.paddingExtraLarge),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: uiConstants.paddingLarge,
                vertical: uiConstants.paddingMedium,
              ),
              child: FilledButton.icon(
                onPressed: () => appRouter.go(ScreenPaths.home),
                label: const Text(
                  'Adicionar produtos',
                  textAlign: TextAlign.center,
                ),
                icon: Icon(
                  Icons.add_shopping_cart_rounded,
                  size: uiConstants.iconSizeMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCartItems(BuildContext context, ProductCart cart) {
    return [
      ListView.builder(
        key: const PageStorageKey<String>('cart-items'),
        addSemanticIndexes: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cart.productsGruppedByProductId.length,
        itemBuilder: (context, index) {
          final productGroup = cart.productsGruppedByProductId[index];
          return _buildCartItem(context, cart, productGroup);
        },
      ),
      Divider(height: uiConstants.dividerHeightMedium),
      SizedBox(height: uiConstants.paddingSmall),
      _buildMinimumOrderMessage(context, cart),
      _buildAddProductsButton(context, cart),
    ];
  }

  Widget _buildCartItem(
      BuildContext context, ProductCart cart, List<ProductItem> productGroup) {
    return ListTile(
      contentPadding:
          EdgeInsets.symmetric(horizontal: uiConstants.paddingSmall),
      minVerticalPadding: uiConstants.paddingSmall,
      leading: _buildProductImage(context, productGroup.first.product),
      visualDensity: VisualDensity.compact,
      isThreeLine: true,
      title: Text(
        productGroup.first.product.productName,
        style: Theme.of(context).textTheme.labelLarge,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        semanticsLabel: productGroup.first.product.productName,
      ),
      subtitle: _buildProductDetails(context, productGroup),
      trailing: _buildProductQuantityControl(context, cart, productGroup),
    ).animate().moveX().fade();
  }

  Widget _buildProductImage(BuildContext context, Product product) {
    return SizedBox(
      width: uiConstants.squareImageSizeSmall,
      height: uiConstants.squareImageSizeSmall,
      child: Image.network(
        cacheWidth: 126,
        cacheHeight: 126,
        product.productImageSrc,
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
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildProductDetails(
      BuildContext context, List<ProductItem> productGroup) {
    return SizedBox(
      width: 192,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${productGroup.first.selectedQuantity} ${productGroup.first.product.productUnitOfMeasure} por R\$ ${productGroup.first.product.productPrice.toStringAsFixed(2)}',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            'R\$ ${(productGroup.first.product.productPrice * productGroup.first.selectedQuantity).toStringAsFixed(2)}',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildProductQuantityControl(
      BuildContext context, ProductCart cart, List<ProductItem> productGroup) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary,
          width: uiConstants.dividerHeightMedium,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      width: 104,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            style: ButtonStyle(
              padding:
                  WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
              visualDensity: VisualDensity.compact,
            ),
            icon: Icon(
              productGroup.first.selectedQuantity == 1
                  ? Icons.delete_rounded
                  : Icons.remove_rounded,
            ),
            onPressed: () {
              Provider.of<ProductCart>(context, listen: false).decrementProduct(
                  context, productGroup.first.product, cartService);
            },
          ),
          Text(
            productGroup.first.selectedQuantity.toString(),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          IconButton(
            style: ButtonStyle(
              padding:
                  WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
              visualDensity: VisualDensity.compact,
            ),
            icon: const Icon(Icons.add_rounded),
            onPressed: () {
              Provider.of<ProductCart>(context, listen: false).incrementProduct(
                  context, productGroup.first.product, cartService);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMinimumOrderMessage(BuildContext context, ProductCart cart) {
    if (cart.isMinimumOrder) return const SizedBox();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.warning_rounded,
          size: uiConstants.iconSizeMedium,
          color: uiConstants.yellowSubmarine,
        ),
        SizedBox(width: uiConstants.paddingExtraSmall),
        SizedBox(
          height: 56,
          width: MediaQuery.sizeOf(context).width - 64,
          child: Center(
            child: Text(
              'Adicione mais R\$ ${(cart.minimumOrder - cart.totalPrice).toStringAsFixed(2)} para atingir o valor mínimo.',
              style: Theme.of(context).textTheme.labelMedium,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Padding _buildAddProductsButton(BuildContext context, ProductCart cart) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: uiConstants.paddingLarge,
        vertical: uiConstants.paddingMedium,
      ),
      child: FilledButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: cart.isMinimumOrder
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.primary,
        ),
        onPressed: () => appRouter.go(ScreenPaths.home),
        label: Text(
          cart.isMinimumOrder
              ? 'Adicionar outros produtos'
              : 'Adicionar mais produtos',
          style: TextStyle(
            color: cart.isMinimumOrder
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surface,
          ),
          textAlign: TextAlign.center,
        ),
        icon: Icon(
          Icons.add_shopping_cart_rounded,
          color: cart.isMinimumOrder
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          size: uiConstants.iconSizeMedium,
        ),
      ),
    );
  }
}
