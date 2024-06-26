import '../../common_libs.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductCart>(builder: (context, cart, child) {
      const String bottomSheetTitle = 'Total';
      const String bottomSheetCtaButtonText = 'Pedir agora';
      const String bottomSheetCtaButtonTextDisabled = 'Pedido min. R\$10';

      return Container(
        padding: EdgeInsets.symmetric(horizontal: uiConstants.paddingMedium),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
              width: uiConstants.borderSideWidthMedium,
            ),
          ),
        ),
        height: uiConstants.bottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bottomSheetTitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'R\$ ${cart.totalPrice.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                visualDensity: VisualDensity.standard,
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.symmetric(
                  horizontal: uiConstants.paddingMedium,
                  vertical: uiConstants.paddingMedium,
                ),
                elevation: 2,
                maximumSize: const Size(
                  180,
                  72,
                ),
              ),
              onPressed: cart.isMinimumOrder
                  ? () {
                      appRouter.push(ScreenPaths.checkout);
                    }
                  : null,
              icon: Icon(
                cart.isMinimumOrder
                    ? Icons.shopping_basket_rounded
                    : Icons.shopping_basket_outlined,
                size: uiConstants.iconSizeMedium,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              label: FittedBox(
                child: Text(
                  cart.isMinimumOrder
                      ? bottomSheetCtaButtonText
                      : bottomSheetCtaButtonTextDisabled,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
