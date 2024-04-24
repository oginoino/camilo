import 'dart:async';

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
    Timer? timer;
    bool menuOpen = true;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = RelativeRect.fromLTRB(
      renderBox
          .localToGlobal(
              Offset(renderBox.size.width - 142, renderBox.size.height - 120))
          .dx,
      renderBox.localToGlobal(Offset.zero).dy,
      renderBox.localToGlobal(Offset.zero).dx,
      renderBox.localToGlobal(Offset.zero).dy,
    );

    void restartTimer() {
      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }
      timer = Timer(const Duration(milliseconds: 2500), () {
        if (menuOpen) {
          Navigator.of(context, rootNavigator: true).pop();
          menuOpen = false;
        }
      });
    }

    restartTimer();

    Future<Widget?> menu = showMenu(
      constraints: const BoxConstraints(maxWidth: 140),
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      position: position,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      popUpAnimationStyle: AnimationStyle(
        reverseDuration: const Duration(milliseconds: 100),
      ),
      useRootNavigator: true,
      color: Theme.of(context).colorScheme.primary,
      items: [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          height: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Consumer<ProductList>(builder: (context, products, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: UiConstants().paddingSmall),
                    child: IconButton(
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        tooltip: 'Remover',
                        onPressed: () {
                          if (product.selectedQuantity > 0) {
                            updateProductSelectedQuantity(isIncrement: false);
                          }
                          restartTimer();
                        },
                        iconSize: uiConstants.iconSizeMedium,
                        icon: Icon(
                          product.selectedQuantity < 1
                              ? null
                              : product.selectedQuantity == 1
                                  ? Icons.delete
                                  : Icons.remove_rounded,
                          color: Theme.of(context).colorScheme.background,
                        )),
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      minWidth: 40,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: UiConstants().paddingSmall,
                      vertical: UiConstants().paddingExtraSmall,
                    ),
                    child: Text(
                      products
                          .getProductById(product.id)
                          .selectedQuantity
                          .toString(),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.background,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: UiConstants().paddingSmall),
                    child: IconButton(
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      tooltip: 'Adicionar',
                      onPressed: () {
                        updateProductSelectedQuantity(isIncrement: true);
                        restartTimer();
                      },
                      iconSize: uiConstants.iconSizeMedium,
                      icon: Icon(
                        Icons.add_rounded,
                        color: product.availableQuantity <=
                                product.selectedQuantity
                            ? Colors.transparent
                            : Theme.of(context).colorScheme.background,
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ],
    );

    menu.then((value) {
      menuOpen = false;
      if (timer != null && timer!.isActive) {
        timer?.cancel();
      }
    });

    return menu;
  }
}
