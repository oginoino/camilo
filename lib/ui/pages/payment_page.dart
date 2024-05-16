import '../../common_libs.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Checkout>(builder: (context, checkout, child) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                checkout.payment!.paymentMethod.methodDescription,
              ),
              floating: true,
              snap: true,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  appRouter.pop();
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
