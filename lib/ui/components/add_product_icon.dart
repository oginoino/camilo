import '../../common_libs.dart';

class AddProductIcon extends StatelessWidget {
  const AddProductIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
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
