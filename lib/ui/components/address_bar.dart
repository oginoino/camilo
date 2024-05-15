import '../../common_libs.dart';

class AddressBar extends StatefulWidget {
  const AddressBar({super.key});

  @override
  State<AddressBar> createState() => _AddressBarState();
}

class _AddressBarState extends State<AddressBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            useSafeArea: true,
            useRootNavigator: false,
            showDragHandle: true,
            isScrollControlled: true,
            enableDrag: true,
            builder: (context) {
              return const SearchAddressBottomSheet();
            },
          ).whenComplete(() {
            setState(() {});
          });
        },
        icon: Icon(
          Icons.location_on_rounded,
          color: Theme.of(context).colorScheme.secondary,
        ),
        label: Hero(
          tag: 'search-address',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: FittedBox(
                  child: Text(
                    context.read<Session>().selectedAddress?.mainText ??
                        'Adicionar endereço',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_drop_down_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
