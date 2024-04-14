import '../../common_libs.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double contaninerWidth = 160.0;
    double contaninerHeght = 160.0;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(uiConstants.paddingMedium),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(uiConstants.paddingMedium),
                    topRight: Radius.circular(uiConstants.paddingMedium),
                  ),
                ),
                width: contaninerWidth,
                height: contaninerHeght,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(uiConstants.paddingMedium),
                    topRight: Radius.circular(uiConstants.paddingMedium),
                  ),
                  child: Image.network(
                    'https://via.placeholder.com/200',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text('Produto 1'),
              const Text('R\$ 10,00'),
            ],
          ),
          const AddProductIcon(),
        ],
      ),
    );
  }
}

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
