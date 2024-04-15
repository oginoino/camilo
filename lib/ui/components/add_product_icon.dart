import '../../common_libs.dart';

class AddProductIcon extends StatefulWidget {
  const AddProductIcon({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<AddProductIcon> createState() => _AddProductIconState();
}

class _AddProductIconState extends State<AddProductIcon> {
  @override
  Widget build(BuildContext context) {
    double addIconPositionTop = 0.0;
    double addIconPositionRight = 0.0;

    return Positioned(
      top: addIconPositionTop,
      right: addIconPositionRight,
      child: IconButton(
        icon: widget.product.selectedQuantity == 0
            ? Icon(
                Icons.add_circle_rounded,
                color: Theme.of(context).colorScheme.secondary,
                size: uiConstants.iconSizeLarge,
              )
            : CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                radius: uiConstants.iconSizeSmall,
                child: Text(
                  widget.product.selectedQuantity.toString(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.background,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
        onPressed: () {
          if (widget.product.selectedQuantity == 0) {
            setState(() {
              widget.product.incrementQuantity();
            });
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
      items: [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          height: 0,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateMenu) {
              return Container(
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
                        onPressed: () {
                          updateQuantity(isIncrement: false);
                          setStateMenu(() {});
                        },
                        icon: Icon(
                          Icons.remove_rounded,
                          size: uiConstants.iconSizeSmall,
                          color: Theme.of(context).colorScheme.tertiary,
                        )),
                    Text(
                      widget.product.selectedQuantity.toString(),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          updateQuantity(isIncrement: true);
                          setStateMenu(() {});
                        },
                        icon: Icon(
                          Icons.add_rounded,
                          size: uiConstants.iconSizeSmall,
                          color: Theme.of(context).colorScheme.tertiary,
                        ))
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void updateQuantity({required bool isIncrement}) {
    if (isIncrement) {
      widget.product.incrementQuantity();
    } else {
      widget.product.decrementQuantity();
    }
    setState(() {}); // This will refresh the main icon state
  }
}
