import '../../common_libs.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomAppBar(),
        _buildPageBody(context),
      ],
    );
  }

  SliverList _buildPageBody(BuildContext context) {
    List<String> categories = [
      'Destaques',
      'Promoções',
      'Favoritos',
      'Verduras',
      'Carnes',
      'Peixes',
      'Bebidas',
      'Laticínios',
      'Padaria',
      'Higiene',
      'Limpeza',
    ];
    return SliverList.list(children: [
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: uiConstants.paddingSmall,
          vertical: uiConstants.paddingMedium,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ProductCarossel(category: categories[index]);
          },
        ),
      )
    ]);
  }
}
