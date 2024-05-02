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
