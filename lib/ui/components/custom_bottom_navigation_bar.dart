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
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  padding: EdgeInsets.symmetric(
                    horizontal: uiConstants.paddingMedium,
                    vertical: uiConstants.paddingSmall,
                  ),
                  elevation: 2),
              onPressed: () {},
              icon: Icon(
                Icons.payment_rounded,
                size: uiConstants.iconSizeSmall,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              label: Text(
                bottomSheetCtaButtonText,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
