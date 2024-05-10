import 'package:camilo/common_libs.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          TextButton.icon(
            onPressed: () {
              products.getAllProducts();
              appRouter.canPop()
                  ? appRouter.pop()
                  : appRouter.go(ScreenPaths.home);
              categorySelection.selectCategory('Tudo');
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
            label: Text('Voltar',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600)),
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
