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
              padding: EdgeInsets.only(top: uiConstants.paddingMedium),
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
          } else if (productsService.isLoading) {
            return Center(
              child: Padding(
                padding:
                    EdgeInsets.only(top: uiConstants.paddingExtraExtraLarge),
                child: const CircularProgressIndicator(),
              ),
            );
          } else {
            return const CustomVoidSearch(
              message: 'Nenhum produto foi encontrado para o termo digitado.',
            );
          }
        })
      ],
    );
  }
}
