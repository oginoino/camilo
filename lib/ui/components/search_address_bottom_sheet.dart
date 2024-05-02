import '../../common_libs.dart';

class SearchAddressBottomSheet extends StatelessWidget {
  const SearchAddressBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(uiConstants.paddingMedium),
      child: Column(
        children: [
          SearchBar(
            leading: IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {},
            ),
            trailing: [
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {},
              ),
            ],
            hintText: 'Buscar endereço',
            onChanged: (value) {},
          ),
          SizedBox(height: uiConstants.paddingMedium),
        ],
      ),
    );
  }
}
