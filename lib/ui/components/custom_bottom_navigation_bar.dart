import '../../common_libs.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductCart>(builder: (context, cart, child) {
      return ListTile(
        title: const Text('Total'),
        subtitle: Text('R\$ ${cart.totalPrice.toStringAsFixed(2)}'),
        trailing: ElevatedButton.icon(
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
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
          ),
        ),
      );
    });
  }
}
