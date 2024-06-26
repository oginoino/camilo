import '../../common_libs.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double expandedHeight = 210.0;
    double collapsedHeight = 160.0;
    double expandedTitleScale = 1.05;

    return SliverAppBar(
      leading: IconButton(
        icon: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.person_rounded,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: const [
        CartIcon(),
      ],
      title: const AddressBar(),
      floating: true,
      snap: true,
      pinned: false,
      forceElevated: false,
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      shadowColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        collapseMode: CollapseMode.parallax,
        expandedTitleScale: expandedTitleScale,
        titlePadding: EdgeInsets.zero,
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomTopBoxAdapter(),
            CustomSearchProductsBar(),
            CategoriesMenu(),
          ],
        ),
      ),
    );
  }
}
