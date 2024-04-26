import '../../common_libs.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomAppBar(),
        _buildSliverTopBoxAdapter(context),
        const CustomPageBody()
      ],
    );
  }

  CustomTopBoxAdapter _buildSliverTopBoxAdapter(BuildContext context) {
    return const CustomTopBoxAdapter();
  }
}


