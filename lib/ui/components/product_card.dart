import '../../common_libs.dart';
import '../../models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  Product get product => GetIt.I<Product>();

  @override
  Widget build(BuildContext context) {
    double contaninerWidth = 160.0;
    double contaninerHeght = 160.0;
    double cardElevation = 0.0;

    const String productUnitOfMeasurement = 'unidade(s)';
    const String productUnitQuantity = '1';
    const String productName =
        'Sorvete Ben & Jerry\'s morango com pedaços de chocolate e biscoito';
    const String productPrice = '10,00';
    const String productImageSrc =
        'https://acdn.mitiendanube.com/stores/001/165/503/products/coca-zero21-16e7cba0588363da7616192142363168-640-0.png';

    return Card(
      color: Theme.of(context).colorScheme.background,
      elevation: cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(uiConstants.paddingMedium),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              SizedBox(
                height: 100,
                width: contaninerWidth,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: uiConstants.paddingSmall),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            productUnitQuantity,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          SizedBox(width: uiConstants.paddingExtraSmall),
                          Text(
                            productUnitOfMeasurement,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                        child: Text(
                          productName,
                          style: Theme.of(context).textTheme.labelMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          semanticsLabel: productName,
                        ),
                      ),
                      Text(
                        'R\$ $productPrice',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
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
