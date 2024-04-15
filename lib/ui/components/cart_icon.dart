import '../../common_libs.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double positionBadgeRight = 4.0;
    double positionBadgeBotton = 4.0;
    double badgeSmallSize = 18.0;
    double badgeLargeSize = 18.0;

    return Stack(
      children: [
        IconButton(
          icon: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(
              Icons.shopping_cart_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          onPressed: () {},
        ),
        Positioned(
          right: positionBadgeRight,
          bottom: positionBadgeBotton,
          child: Badge(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            smallSize: badgeSmallSize,
            largeSize: badgeLargeSize,
            padding: EdgeInsets.symmetric(
              horizontal: uiConstants.paddingExtraSmall,
            ),
            isLabelVisible: true,
            textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
            label: const Center(
              child: Text(
                '0',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}
