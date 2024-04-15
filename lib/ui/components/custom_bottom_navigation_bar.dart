import '../../common_libs.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductCart>(builder: (context, cart, child) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: uiConstants.paddingMedium),
        decoration: BoxDecoration(
          color:
              Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5),
        ),
        height: 80.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total', style: Theme.of(context).textTheme.bodyMedium),
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
                    vertical: uiConstants.paddingSmall),
              ),
              onPressed: () {},
              icon: Icon(
                Icons.payment_rounded,
                size: uiConstants.iconSizeSmall,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              label: Text(
                'Pagar',
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
