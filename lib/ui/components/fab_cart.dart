import '../../common_libs.dart';

class FABCart extends StatelessWidget {
  const FABCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(uiConstants.borderRadiusLarge),
      ),
      onPressed: () {
        appRouter.push(ScreenPaths.cart);
      },
      label: Text(
        'Ir para o carrinho',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      icon: const Icon(Icons.shopping_cart),
      key: const Key('fab_cart'),
    );
  }
}
