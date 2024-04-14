import '../../common_libs.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(uiConstants.paddingMedium),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(uiConstants.paddingMedium),
                topRight: Radius.circular(uiConstants.paddingMedium),
              ),
            ),
            width: 160,
            height: 160,
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
    );
  }
}
