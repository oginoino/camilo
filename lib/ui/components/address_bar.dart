import '../../common_libs.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
        ),
        onPressed: () {},
        icon: Icon(
          Icons.location_on_rounded,
          color: Theme.of(context).colorScheme.secondary,
        ),
        label: Hero(
          tag: 'search-address',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Adicionar endereço',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.secondary),
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