import '../../common_libs.dart';

class CategoriesMenu extends StatelessWidget {
  const CategoriesMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductList, CategorySelection>(
      builder: (context, products, categorySelection, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: uiConstants.paddingSmall),
          child: SizedBox(
            height: 50.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: false,
              itemCount: products.categories.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding:
                        EdgeInsets.only(right: uiConstants.paddingExtraSmall),
                    child: CategoryNavItemMobile(
                      categoryTitle: 'Tudo',
                      isSelected: categorySelection.selectedCategory == 'Tudo',
                      onTap: () {
                        categorySelection.selectCategory('Tudo');
                        products.getAllProducts();
                      },
                    ),
                  );
                } else {
                  String category = products.categories[index - 1];
                  return Padding(
                    padding:
                        EdgeInsets.only(left: uiConstants.paddingExtraSmall),
                    child: CategoryNavItemMobile(
                      categoryTitle: category,
                      isSelected:
                          categorySelection.selectedCategory == category,
                      onTap: () {
                        categorySelection.selectCategory(category);
                      },
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

// The individual category item widget
class CategoryNavItemMobile extends StatelessWidget {
  const CategoryNavItemMobile({
    super.key,
    required this.categoryTitle,
    required this.isSelected,
    required this.onTap,
  });

  final String categoryTitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: uiConstants.paddingSmall),
      child: Center(
        child: TextButton(
          onPressed: onTap,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(
                horizontal: uiConstants.paddingMedium,
              ),
            ),
            overlayColor: MaterialStateProperty.all(
              uiConstants.cyanGreen,
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (isSelected ||
                    states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed)) {
                  return uiConstants.backgroundLight;
                }
                return uiConstants.primaryLight;
              },
            ),
            side: MaterialStateProperty.all(
              BorderSide(
                color: uiConstants.primaryLight,
                width: 1.0,
              ),
            ),
            textStyle: MaterialStateProperty.all(
              Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (isSelected ||
                    states.contains(MaterialState.hovered) ||
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
                  uiConstants.borderRadiusMedium,
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
