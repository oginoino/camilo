import '../../common_libs.dart';

class CategoriesMenu extends StatelessWidget {
  const CategoriesMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductList>(builder: (context, products, child) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          const CategoryNavItemMobile(
            categoryTitle: 'Todas',
          ),
          ...products.categories.map(
            (category) => Padding(
              padding: EdgeInsets.only(
                left: uiConstants.paddingExtraExtraSmall,
              ),
              child: CategoryNavItemMobile(
                categoryTitle: category,
              ),
            ),
          ),
        ]),
      );
    });
  }
}

class CategoryNavItemMobile extends StatelessWidget {
  const CategoryNavItemMobile({
    super.key,
    required this.categoryTitle,
  });

  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: uiConstants.paddingSmall),
      child: Center(
        child: TextButton(
          onPressed: () {},
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(
                horizontal: uiConstants.borderRadiusSmall,
              ),
            ),
            overlayColor: MaterialStateProperty.all(
              uiConstants.cyanGreen,
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.selected) ||
                    states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed)) {
                  return uiConstants.backgroundLight;
                }
                return uiConstants.primaryLight;
              },
            ),
            textStyle: MaterialStateProperty.all(
              Theme.of(context).textTheme.labelMedium,
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.selected) ||
                    states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed)) {
                  return uiConstants.primaryLight;
                }
                return uiConstants.backgroundLight;
              },
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  uiConstants.borderRadiusSmall,
                ),
              ),
            ),
          ),
          child: Text(
            categoryTitle,
          ),
        ),
      ),
    );
  }
}
