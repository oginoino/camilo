import '../../common_libs.dart';

class FABCart extends StatelessWidget {
  const FABCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        appRouter.push(ScreenPaths.cart);
      },
      label: const Text('Ir para o carrinho'),
      icon: const Icon(Icons.shopping_cart),
      key: const Key('fab_cart'),
    );
  }
}
