import '../../common_libs.dart';

class AddProductIcon extends StatelessWidget {
  const AddProductIcon({
    super.key,
  });

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
          _buildAddProductTooltip(context);
        },
      ),
    );
  }
}

void _buildAddProductTooltip(BuildContext context) {
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

  showMenu(
    constraints: const BoxConstraints(maxWidth: 120),
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    position: position,
    items: [
      PopupMenuItem(
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
              '1',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Icon(
                  Icons.add_rounded,
                  size: uiConstants.iconSizeSmall,
                ))
          ],
        ),
      ),
    ],
  );
}
