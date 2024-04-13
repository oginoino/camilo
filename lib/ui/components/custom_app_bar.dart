import '../../common_libs.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        icon: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.person_rounded,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(
              Icons.shopping_cart_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          onPressed: () {},
        ),
      ],
      title: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
        ),
        onPressed: () {},
        icon: Icon(
          Icons.location_on_rounded,
          color: Theme.of(context).colorScheme.secondary,
        ),
        label: Hero(
          tag: 'search-address',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Adicionar endereço',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              Icon(
                Icons.arrow_drop_down_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
      floating: true,
      snap: true,
      pinned: false,
      forceElevated: false,
      expandedHeight: 140,
      collapsedHeight: 108,
      flexibleSpace: const FlexibleSpaceBar(
        centerTitle: false,
        collapseMode: CollapseMode.parallax,
        title: CustomSearchBar(),
        expandedTitleScale: 1.1,
        titlePadding: EdgeInsets.zero,
      ),
    );
  }
}
