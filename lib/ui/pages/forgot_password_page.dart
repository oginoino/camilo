import '../../common_libs.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

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
        reverse: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppLogo(),
              ForgotPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}
