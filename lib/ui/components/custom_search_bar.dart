import '../../common_libs.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String hintTextValue = 'O que você precisa hoje?';
    FocusNode focusNodeValue = FocusNode();
    TextEditingController textEditingControllerValue = TextEditingController();

    double value = 0.0;
    double minHeight = 40.0;
    double maxHeight = 40.0;

    return Padding(
      padding: EdgeInsets.all(uiConstants.paddingSmall),
      child: SearchBar(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        focusNode: focusNodeValue,
        controller: textEditingControllerValue,
        hintText: hintTextValue,
        trailing: [
          Icon(
            Icons.search_rounded,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
        elevation: MaterialStateProperty.all(value),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        constraints: BoxConstraints(
          minHeight: minHeight,
          maxHeight: maxHeight,
          maxWidth: double.infinity,
          minWidth: double.infinity,
        ),
        textStyle: MaterialStateProperty.all(
          Theme.of(context).textTheme.labelMedium,
        ),
        onChanged: (value) {},
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