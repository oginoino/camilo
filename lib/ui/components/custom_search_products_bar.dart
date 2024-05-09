import '../../common_libs.dart';

class CustomSearchProductsBar extends StatefulWidget {
  const CustomSearchProductsBar({super.key});

  @override
  CustomSearchProductsBarState createState() => CustomSearchProductsBarState();
}

class CustomSearchProductsBarState extends State<CustomSearchProductsBar> {
  final TextEditingController searchProductsTextEditingControllerValue =
      TextEditingController();
  bool _showClearIcon = false;

  @override
  void initState() {
    super.initState();
    searchProductsTextEditingControllerValue.addListener(_updateClearIcon);
  }

  @override
  void dispose() {
    searchProductsTextEditingControllerValue.removeListener(_updateClearIcon);
    searchProductsTextEditingControllerValue.dispose();
    super.dispose();
  }

  void _updateClearIcon() {
    setState(() {
      _showClearIcon = searchProductsTextEditingControllerValue.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    const String hintTextValue = 'O que você precisa?';
    const String searchIconText = 'Buscar produtos';
    const String clearSearchIconText = 'Apagar busca';

    FocusNode focusNodeValue = FocusNode();

    const double value = 0.0;
    const double minHeight = 40.0;
    const double maxHeight = 40.0;

    return Padding(
      padding: EdgeInsets.all(uiConstants.paddingSmall),
      child: SearchBar(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        focusNode: focusNodeValue,
        controller: searchProductsTextEditingControllerValue,
        hintText: hintTextValue,
        trailing: _showClearIcon
            ? [
                GestureDetector(
                  onTap: () {
                    searchProductsTextEditingControllerValue.clear();
                    products.getAllProducts();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(uiConstants.paddingSmall),
                    child: Row(
                      children: [
                        Text(
                          clearSearchIconText,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(width: uiConstants.paddingSmall),
                        Icon(
                          Icons.close_rounded,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            : [
                Text(
                  searchIconText,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                IconButton(
                  onPressed: () {
                    focusNodeValue.requestFocus();
                  },
                  icon: Icon(
                    Icons.search_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ],
        elevation: MaterialStateProperty.all(value),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        constraints: const BoxConstraints(
          minHeight: minHeight,
          maxHeight: maxHeight,
          maxWidth: double.infinity,
          minWidth: double.infinity,
        ),
        textStyle: MaterialStateProperty.all(
          Theme.of(context).textTheme.labelMedium,
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            products.searchProducts(value);
          } else {
            products.getAllProducts();
          }
        },
        onSubmitted: (value) {
          focusNodeValue.unfocus();
        },
        onTap: () {
          focusNodeValue.requestFocus();
        },
      ),
    );
  }
}
