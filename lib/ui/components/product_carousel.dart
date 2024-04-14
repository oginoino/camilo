import '../../common_libs.dart';

class ProductCarossel extends StatelessWidget {
  const ProductCarossel({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: uiConstants.cyanGreen,
              ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Row(
                children: [
                  const ProductCard(),
                  const ProductCard(),
                  const ProductCard(),
                  const ProductCard(),
                  const ProductCard(),
                  const ProductCard(),
                  const ProductCard(),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: uiConstants.paddingSmall),
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            const Text('Ver tudo'),
                            SizedBox(width: uiConstants.paddingExtraSmall),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: uiConstants.iconSizeSmall,
                              opticalSize: uiConstants.iconSizeSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
