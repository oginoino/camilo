import '../../common_libs.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      reverse: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            AppLogo(),
            // LoginForm(),
          ],
        ),
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Text(
        'Camilo',
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
