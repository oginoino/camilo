import '../../common_libs.dart';

class AddProductIcon extends StatelessWidget {
  const AddProductIcon({
    super.key,
    required this.product,
    required this.updateProductSelectedQuantity,
    required int productSelectedQuantity,
  });

  final Product product;

  final Function updateProductSelectedQuantity;

  @override
  Widget build(BuildContext context) {
    double addIconPositionTop = 0.0;
    double addIconPositionRight = 0.0;

    return Positioned(
      top: addIconPositionTop,
      right: addIconPositionRight,
      child: IconButton(
        tooltip: 'Adicionar ou remover',
        icon: product.selectedQuantity == 0
            ? CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.background,
                radius: uiConstants.iconSizeSmall,
                child: Icon(
                  Icons.add_circle_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                  size: uiConstants.iconSizeLarge,
                ),
              )
            : CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                radius: uiConstants.iconSizeSmall,
                child: Text(
                  product.selectedQuantity.toString(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.background,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
        onPressed: () {
          if (product.selectedQuantity == 0) {
            updateProductSelectedQuantity(isIncrement: true);
          }
          showIncrementMenu(context);
        },
      ),
    );
  }

  Future<dynamic> showIncrementMenu(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = RelativeRect.fromLTRB(
      renderBox
          .localToGlobal(
              Offset(renderBox.size.width - 120, renderBox.size.height - 120))
          .dx,
      renderBox.localToGlobal(Offset.zero).dy,
      renderBox.localToGlobal(Offset.zero).dx,
      renderBox.localToGlobal(Offset.zero).dy,
    );

    return showMenu(
      constraints: const BoxConstraints(maxWidth: 120),
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      position: position,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      popUpAnimationStyle: AnimationStyle(
        reverseDuration: const Duration(milliseconds: 100),
      ),
      useRootNavigator: true,
      items: [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          height: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    tooltip: 'Remover',
                    onPressed: () {
                      updateProductSelectedQuantity(isIncrement: false);
                    },
                    icon: Icon(
                      product.selectedQuantity == 1
                          ? Icons.delete_rounded
                          : Icons.remove_rounded,
                      size: uiConstants.iconSizeSmall,
                      color: Theme.of(context).colorScheme.tertiary,
                    )),
                Consumer<ProductList>(builder: (context, products, child) {
                  return Text(
                      products
                          .getProductById(product.id)
                          .selectedQuantity
                          .toString(),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                          ));
                }),
                IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    tooltip: 'Adicionar',
                    onPressed: () {
                      updateProductSelectedQuantity(isIncrement: true);
                    },
                    icon: Icon(
                      Icons.add_rounded,
                      size: uiConstants.iconSizeSmall,
                      color: Theme.of(context).colorScheme.tertiary,
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
