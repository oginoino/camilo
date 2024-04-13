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
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text('Ver tudo'),
                            SizedBox(width: 4.0),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16.0,
                              opticalSize: 16.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
