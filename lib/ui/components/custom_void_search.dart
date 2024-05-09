import '../../common_libs.dart';

class CustomVoidSearch extends StatelessWidget {
  const CustomVoidSearch({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.5,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded,
                size: 100, color: uiConstants.primaryLight),
            Text(
              message,
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
}
