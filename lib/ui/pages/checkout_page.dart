import '../../common_libs.dart';
import '../components/cart_summary.dart';

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
        SizedBox(height: uiConstants.paddingMedium),
        Text(
          'Método de pagamento',
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
}

enum PaymentMethod {
  pix,
  creditCard,
}

extension PaymentMethodExtension on PaymentMethod {
  String get name {
    switch (this) {
      case PaymentMethod.pix:
        return 'Pix';
      case PaymentMethod.creditCard:
        return 'Cartão de crédito';
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

class PaymentMethodSelector extends StatefulWidget {
  final List<PaymentMethod> paymentMethods;
  final ValueChanged<int> onSelected;
  final int selectedMethod;

  const PaymentMethodSelector({
    super.key,
    required this.paymentMethods,
    required this.onSelected,
    this.selectedMethod = 0,
  });

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  late int _selectedMethod;

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.selectedMethod;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Selected method: $_selectedMethod');
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.paymentMethods.length,
      itemBuilder: (context, index) {
        final method = widget.paymentMethods[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            method.icon,
            size: uiConstants.iconRadiusLarge,
          ),
          title: Text(
            method.name,
            style: Theme.of(context).listTileTheme.titleTextStyle?.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
          trailing: Radio<int>(
            value: index,
            groupValue: _selectedMethod,
            onChanged: (value) {
              setState(() {
                _selectedMethod = value!;
              });
              widget.onSelected(_selectedMethod);
            },
          ),
        );
      },
    );
  }
}
