import '../../common_libs.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('Seu carrinho'),
          leading: BackButton(
            style: ButtonStyle(),
          ),
        ),
      ],
    );
  }
}
