import '../../../common_libs.dart';

class ForgotPasswordForm extends StatelessWidget {
  ForgotPasswordForm({super.key});

  final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey<FormState>();

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
    const String title = 'Informe o E-mail cadastrado para recuperar a senha';

    const String ctaButtonText = 'Recuperar senha';

    const String helperPassword =
        'O link de recuperação será enviado para o email cadastrado';

    const String passwordButtonText = 'Ajuda com a senha?';

    const String helperLogin = 'Lembrou a senha?';

    const String helperLoginText = 'Faça login';

    const String emailForgotPasswordInputKey =
        'email-forgot-password-input-key';

    const String forgotPasswordInputEmailHintText = 'Email cadastrado';

    FocusNode forgotPasswordEmailFocusNode = FocusNode();

    FocusNode forgotPasswordCtaFocusNode = FocusNode(
      skipTraversal: true,
    );

    return Padding(
      padding: EdgeInsets.all(uiConstants.paddingExtraLarge),
      child: FocusScope(
        child: Form(
          key: _forgotPasswordFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: uiConstants.paddingExtraExtraLarge,
              ),
              TextFormField(
                key: const Key(emailForgotPasswordInputKey),
                controller: _forgotPasswordEmailController,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                decoration: const InputDecoration(
                  hintText: forgotPasswordInputEmailHintText,
                ),
                validator: (String? value) {
                  return null;
                },
                onEditingComplete: () {
                  forgotPasswordEmailFocusNode.unfocus();
                  forgotPasswordCtaFocusNode.requestFocus();
                },
                onTapOutside: ((event) => forgotPasswordEmailFocusNode.unfocus()),
                focusNode: forgotPasswordEmailFocusNode,
              ),
              SizedBox(
                height: uiConstants.paddingExtraExtraLarge,
              ),
              FilledButton(
                onPressed: () {},
                focusNode: forgotPasswordCtaFocusNode,
                child: const Text(ctaButtonText),
              ),
              SizedBox(
                height: uiConstants.paddingExtraLarge,
              ),
              Text(
                helperPassword,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  passwordButtonText,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    helperLogin,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: uiConstants.paddingMedium),
                  TextButton(
                    onPressed: () {
                      appRouter.canPop()
                          ? appRouter.pop()
                          : appRouter.push(ScreenPaths.login);
                    },
                    child: Text(
                      helperLoginText,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
