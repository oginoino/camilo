import 'package:camilo/main.dart';

import '../../common_libs.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double contaninerWidth = 160.0;
    double contaninerHeght = 160.0;

    const String productUnitOfMeasurement = 'unidade(s)';
    const String productQuantity = '1';
    const String productName = 'Produto 1';
    const String productPrice = '10,00';
    const String productImageSrc = 'https://via.placeholder.com/200';

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(uiConstants.paddingMedium),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    productImageSrc,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: uiConstants.paddingSmall),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          productQuantity,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        SizedBox(width: uiConstants.paddingExtraSmall),
                        Text(
                          productUnitOfMeasurement,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Text(
                      productName,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text('R\$ $productPrice',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
          const AddProductIcon(),
        ],
      ),
    );
  }
}
