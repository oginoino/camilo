import '../../common_libs.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductCart>(builder: (
      context,
      productCart,
      child,
    ) {
      return Scaffold(
        body: const CustomScrollView(
          slivers: [
            CustomAppBar(),
            CustomPageBody(),
          ],
        ),
        floatingActionButton:
            productCart.isMinimumOrder ? const FABCart() : null,
        extendBody: true,
        resizeToAvoidBottomInset: false,
        primary: true,
        key: const Key('home_page'),
        restorationId: 'home_page',
        drawer: const CustomDrawer(),
      );
    });
  }
}
