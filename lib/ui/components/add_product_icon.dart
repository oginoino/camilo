import '../../common_libs.dart';

class AddProductIcon extends StatelessWidget {
  const AddProductIcon({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    double addIconPositionTop = 0.0;
    double addIconPositionRight = 0.0;

    return Positioned(
      top: addIconPositionTop,
      right: addIconPositionRight,
      child: IconButton(
        icon: Icon(
          Icons.add_circle_rounded,
          color: Theme.of(context).colorScheme.secondary,
          size: uiConstants.iconSizeLarge,
        ),
        onPressed: () {
          _buildAddProductTooltip(context, product);
        },
      ),
    );
  }
}

void _buildAddProductTooltip(BuildContext context, Product product) {
  final RenderBox renderBox = context.findRenderObject() as RenderBox;

  final position = RelativeRect.fromLTRB(
    renderBox
        .localToGlobal(Offset(
          renderBox.size.width - 120,
          renderBox.size.height - 120,
        ))
        .dx,
    renderBox.localToGlobal(Offset.zero).dy,
    renderBox.localToGlobal(Offset.zero).dx,
    renderBox.localToGlobal(Offset.zero).dy,
  );

  int selectedQuantity = 1;
  showMenu(
    constraints: const BoxConstraints(maxWidth: 120),
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    position: position,
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove_rounded,
                    size: uiConstants.iconSizeSmall,
                  )),
              Text(
                selectedQuantity.toString(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                onPressed: () {
                  product.incrementQuantity();
                },
                icon: Icon(
                  Icons.add_rounded,
                  size: uiConstants.iconSizeSmall,
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}
