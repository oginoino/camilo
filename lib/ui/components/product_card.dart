import '../../common_libs.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double contaninerWidth = 160.0;
    double contaninerHeght = 160.0;

    const String productName = 'Produto 1';
    const String productPrice = '10,00';
    const String imageSrc = 'https://via.placeholder.com/200';

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
                    imageSrc,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text(productName),
              const Text('R\$ $productPrice'),
            ],
          ),
          const AddProductIcon(),
        ],
      ),
    );
  }
}
