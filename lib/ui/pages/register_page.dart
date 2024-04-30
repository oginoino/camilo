import '../../common_libs.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: uiConstants.backgroundLight,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left_rounded),
          onPressed: () {
            appRouter.canPop()
                ? appRouter.pop()
                : appRouter.go(ScreenPaths.login);
          },
        ),
      ),
      body: const SingleChildScrollView(
        reverse: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppLogo(),
            ],
          ),
        ),
      ),
    );
  }
}
