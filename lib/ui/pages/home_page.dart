import '../../common_libs.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(),
          CustomTopBoxAdapter(),
          CustomPageBody(),
        ],
      ),
      floatingActionButton: SizedBox(),
      extendBody: true,
      resizeToAvoidBottomInset: false,
      primary: true,
      key: Key('home_page'),
      restorationId: 'home_page',
      drawer: CustomDrawer(),
    );
  }
}
