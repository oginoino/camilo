import '../../common_libs.dart';

class SearchAddressBottomSheet extends StatelessWidget {
  SearchAddressBottomSheet({
    super.key,
  });

  final TextEditingController searchAddressTextEditingControllerValue =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNodeValue = FocusNode();
    const String hintTextValue = 'Digite o endereço de entrega';
    return Padding(
      padding: EdgeInsets.all(uiConstants.paddingMedium),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(width: uiConstants.paddingSmall),
              Text(
                'Endereço de entrega',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: uiConstants.paddingMedium),
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
                onPressed: () {
                  searchAddressTextEditingControllerValue.clear();
                },
              ),
            ],
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            focusNode: focusNodeValue,
            controller: searchAddressTextEditingControllerValue,
            hintText: hintTextValue,
            onSubmitted: (value) {
              focusNodeValue.unfocus();
            },
            onChanged: (value) {},
          ),
          SizedBox(height: uiConstants.paddingMedium),
        ],
      ),
    );
  }
}
