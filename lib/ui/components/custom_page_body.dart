import '../../common_libs.dart';

class CustomPageBody extends StatelessWidget {
  const CustomPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        Consumer<ProductList>(builder: (context, products, child) {
          List<String> productCategories = products.categories;
          if (products.products.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: productCategories.length,
              itemBuilder: (context, index) {
                return ProductCarossel(
                  category: productCategories[index],
                  products: products,
                );
              },
            );
          } else {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off_rounded,
                        size: 100, color: uiConstants.primaryLight),
                    const Text(
                      'Nenhum produto foi encontrado para o termo digitado.',
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        products.getAllProducts();
                      },
                      child: const Text('Ver tudo'),
                    ),
                  ],
                ),
              ),
            );
          }
        })
      ],
    );
  }
}
