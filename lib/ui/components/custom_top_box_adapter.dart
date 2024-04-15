import '../../common_libs.dart';

class CustomTopBoxAdapter extends StatelessWidget {
  const CustomTopBoxAdapter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_basket_rounded,
                      size: uiConstants.iconSizeSmall,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    SizedBox(width: uiConstants.paddingExtraSmall),
                    Text(
                      'Mercado aberto agora!',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  'Entrega em até 30 minutos',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
              ],
            ),
          )),
    );
  }
}
