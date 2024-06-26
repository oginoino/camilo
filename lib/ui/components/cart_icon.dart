import '../../common_libs.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double positionBadgeRight = 4.0;
    double positionBadgeBotton = 4.0;
    double badgeSmallSize = 18.0;
    double badgeLargeSize = 18.0;

    return Stack(
      children: [
        IconButton(
          icon: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(
              Icons.shopping_cart_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          onPressed: () {
            appRouter.push(ScreenPaths.cart);
          },
        ),
        Positioned(
          right: positionBadgeRight,
          bottom: positionBadgeBotton,
          child: Consumer<ProductCart>(
            builder:
                (BuildContext context, ProductCart productCart, Widget? child) {
              if (productCart.cartProducts.isEmpty) {
                return Container();
              } else if (productCart.cartProducts.isNotEmpty) {
                return Badge(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  smallSize: badgeSmallSize,
                  largeSize: badgeLargeSize,
                  padding: EdgeInsets.symmetric(
                    horizontal: uiConstants.paddingExtraSmall,
                  ),
                  isLabelVisible: true,
                  textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        leadingDistribution: TextLeadingDistribution.even,
                        fontWeight: FontWeight.bold,
                      ),
                  label: Center(
                    child: Text(
                      // somar todos os produtos do carrinho
                      productCart.cartProducts
                          .fold(
                              0,
                              (previousValue, element) =>
                                  previousValue + element.selectedQuantity)
                          .toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
                    .animate(
                      autoPlay: true,
                    )
                    .scaleXY(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    )
                    .then()
                    .shake(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
              } else {
                return Container();
              }
            },
          ),
        )
      ],
    );
  }
}
