import '../../../common_libs.dart';

class ForgotPasswordForm extends StatelessWidget {
  ForgotPasswordForm({super.key});

  final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey<FormState>();

  final String _emailForgotPasswordInputKey = 'email-forgot-password-input-key';

  final TextEditingController _forgotPasswordEmailController =
      TextEditingController();

  final String title = 'Informe o E-mail cadastrado para recuperar a senha';

  final String ctaButtonText = 'Recuperar senha';

  final String helperPassword =
      'O link de recuperação será enviado para o email cadastrado';

  final String psswordButtonText = 'Ajuda com a senha?';

  String get helperLogin => 'Lembrou a senha?';

  String get helperLoginText => 'Faça login';

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.height * 0.8),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _forgotPasswordFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 80,
              ),
              TextFormField(
                key: Key(_emailForgotPasswordInputKey),
                controller: _forgotPasswordEmailController,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                decoration: const InputDecoration(
                  hintText: 'Informe o email cadastrado',
                ),
                validator: (String? value) {
                  return null;
                },
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
                // remove focus on click outside
                onTapOutside: ((event) => FocusScope.of(context).unfocus()),
              ),
              const SizedBox(
                height: 40,
              ),
              FilledButton(
                onPressed: () {},
                child: Text(ctaButtonText),
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    psswordButtonText,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
              const SizedBox(
                height: 16,
              ),
              Text(
                helperPassword,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    helperLogin,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                      onPressed: () {
                        appRouter.go(ScreenPaths.login);
                      },
                      child: Text(
                        helperLoginText,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
