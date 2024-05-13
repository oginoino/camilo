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
          _buildDeliveryFeeComponent(context),
          const Divider(),
          const CartSummary(),
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
            'Endereço de entrega',
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
      padding: EdgeInsets.only(top: uiConstants.paddingMedium),
      child: const CustomTopBoxAdapter(),
    );
  }

  Widget _buildDeliveryFeeComponent(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        Icons.delivery_dining_rounded,
        size: uiConstants.iconRadiusLarge,
      ),
      title: Text(
        'Taxa de entrega',
        style: Theme.of(context).listTileTheme.titleTextStyle?.copyWith(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
      ),
      trailing: Text(
        'R\$ 5,00',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
