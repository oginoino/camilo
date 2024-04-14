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
        ),
        onPressed: () {},
      ),
    );
  }
}
