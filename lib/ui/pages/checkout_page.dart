import '../../common_libs.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          _buildCheckoutBody(context),
        ],
      ),
      bottomNavigationBar: _buildCheckoutBottomNavigationBar(context),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    const double expandedTitleScale = 1.1;
    const double collapsedHeight = 60.0;
    const double expandedHeight = 60.0;
    return SliverAppBar(
      title: const Text('Checkout do pedido'),
      leading: BackButton(
        onPressed: () {
          appRouter.go(ScreenPaths.cart);
        },
      ),
      floating: true,
      snap: true,
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      flexibleSpace: const FlexibleSpaceBar(
        centerTitle: false,
        collapseMode: CollapseMode.parallax,
        expandedTitleScale: expandedTitleScale,
        titlePadding: EdgeInsets.zero,
      ),
    );
  }

  SliverPadding _buildCheckoutBody(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(uiConstants.paddingMedium),
      sliver: SliverList.list(
        children: [
          _buildAddressComponent(context),
          _buildDeliveryTimeComponent(context),
          const Divider(),
          const CartSummary(),
          const Divider(),
          _buildTotalPriceComponent(context),
          _buildSelectPaymentMethodComponent(context),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildAddressComponent(BuildContext context) {
    return Consumer<Session>(builder: (context, session, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Confirme o endereço de entrega',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: uiConstants.paddingSmall),
          if (session.selectedAddress == null)
            const AddressBar()
          else
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.location_on,
                size: uiConstants.iconRadiusLarge,
              ),
              title: Text(
                session.selectedAddress!.description,
                style: Theme.of(context).listTileTheme.titleTextStyle?.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              trailing: IconButton(
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  size: uiConstants.iconRadiusLarge,
                ),
                onPressed: () {
                  _updateAddress(context);
                },
              ),
            ),
        ],
      );
    });
  }

  void _updateAddress(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      useSafeArea: true,
      useRootNavigator: true,
      showDragHandle: true,
      isScrollControlled: true,
      enableDrag: true,
      builder: (context) {
        return const SearchAddressBottomSheet();
      },
    ).whenComplete(() {
      appRouter.go(ScreenPaths.checkout);
    });
  }

  Widget _buildDeliveryTimeComponent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: uiConstants.paddingSmall, top: uiConstants.paddingLarge),
      child: const CustomTopBoxAdapter(),
    );
  }

  Widget _buildTotalPriceComponent(BuildContext context) {
    return Consumer<ProductCart>(builder: (context, productCart, child) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(
          Icons.receipt_rounded,
          size: uiConstants.iconRadiusLarge,
        ),
        title: Text(
          'Total do pedido',
          style: Theme.of(context).listTileTheme.titleTextStyle?.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
        ),
        trailing: Text(
          'R\$ ${(productCart.totalPrice + 5).toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
        ),
      );
    });
  }

  Widget _buildSelectPaymentMethodComponent(BuildContext context) {
    const paymentMethods = PaymentMethod.values;
    debugPrint('Payment methods: $paymentMethods');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: uiConstants.paddingLarge),
        Text(
          'Escolha como pagar',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: uiConstants.paddingMedium),
        PaymentMethodSelector(
            paymentMethods: paymentMethods,
            onSelected: (index) {
              debugPrint(
                'Selected payment method: ${paymentMethods[index].name}',
              );
            }),
      ],
    );
  }

  Widget _buildCheckoutBottomNavigationBar(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
            onPressed: () {},
            icon: Icon(
              Icons.done_rounded,
              size: uiConstants.iconSizeMedium,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            label: FittedBox(
              child: Text(
                'Finalizar pedido',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum PaymentMethod {
  pix,
  creditCard,
}

extension PaymentMethodExtension on PaymentMethod {
  String get name {
    switch (this) {
      case PaymentMethod.pix:
        return 'Pague com PIX';
      case PaymentMethod.creditCard:
        return 'Escolha o cartão de crédito';
    }
  }

  IconData get icon {
    switch (this) {
      case PaymentMethod.pix:
        return Icons.pix_rounded;
      case PaymentMethod.creditCard:
        return Icons.credit_card_rounded;
    }
  }
}
