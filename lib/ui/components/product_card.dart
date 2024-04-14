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
      child: Column(
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
    );
  }
}
