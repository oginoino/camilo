import '../../common_libs.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      extendBody: true,
      resizeToAvoidBottomInset: false,
    );
  }
}
