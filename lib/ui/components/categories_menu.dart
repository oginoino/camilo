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
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification) {
                  categorySelection
                      .setScrollPosition(notification.metrics.pixels);
                }
                return true;
              },
              child: ListView.builder(
                controller: ScrollController(
                    initialScrollOffset: categorySelection.scrollPosition),
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
                        isSelected:
                            categorySelection.selectedCategory == 'Tudo',
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
                        categoryTitle: category.capitalize(),
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
          ),
        );
      },
    );
  }
}

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
    Widget textButton = TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: uiConstants.paddingMedium,
            vertical: uiConstants.paddingExtraSmall,
          ),
        ),
        overlayColor: WidgetStateProperty.all(
          uiConstants.cyanGreen,
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (isSelected ||
                states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.focused) ||
                states.contains(WidgetState.pressed)) {
              return uiConstants.backgroundLight;
            }
            return uiConstants.primaryLight;
          },
        ),
        side: WidgetStateProperty.all(
          isSelected
              ? BorderSide.none
              : BorderSide(
                  color: uiConstants.primaryLight,
                  width: 1.0,
                ),
        ),
        textStyle: WidgetStateProperty.all(
          Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (isSelected) {
              return Colors
                  .transparent; // Usamos Colors.transparent aqui para usar o Container com gradiente
            } else if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.focused) ||
                states.contains(WidgetState.pressed)) {
              return uiConstants.primaryLight;
            }
            return uiConstants.backgroundLight;
          },
        ),
        shape: WidgetStateProperty.all(
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
    );

    if (isSelected) {
      textButton = Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [uiConstants.secondaryLight, uiConstants.primaryLight],
            stops: const [0, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(uiConstants.borderRadiusMedium),
        ),
        child: textButton,
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: uiConstants.paddingSmall),
      child: Center(
        child: isSelected ? textButton.animate().shimmer() : textButton,
      ),
    );
  }
}
