import '../../common_libs.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      reverse: true,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            AppLogo(),
            LoginForm(),
            // LoginForm(),
          ],
        ),
      ),
    );
  }
}
