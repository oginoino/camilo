import '../../common_libs.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: FittedBox(
        child: TextButton.icon(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
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
            );
          },
          icon: Icon(
            Icons.location_on_rounded,
            color: Theme.of(context).colorScheme.secondary,
          ),
          label: Hero(
            tag: 'search-address',
            child: Consumer<Session>(builder: (context, session, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    session.user?.selectedAddress?.mainText ??
                        'Adicionar endereço',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
