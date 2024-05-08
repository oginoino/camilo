import '../../../common_libs.dart';

class ForgotPasswordForm extends StatelessWidget {
  ForgotPasswordForm({super.key});

  final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey<FormState>();

  final TextEditingController _forgotPasswordEmailController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    const String title = 'Informe o E-mail cadastrado para recuperar a senha';

    const String ctaButtonText = 'Recuperar senha';

    const String helperPassword =
        'O link de recuperação será enviado para o email cadastrado';

    const String helperPasswordButtonText = 'Ajuda com a senha?';

    const String helperLogin = 'Lembrou a senha?';

    const String helperLoginText = 'Faça login';

    const String emailForgotPasswordInputKey =
        'email-forgot-password-input-key';

    const String forgotPasswordInputEmailHintText = 'Email cadastrado';

    const String recoveryMessage =
        'Email de recuperação enviado! Verifique sua caixa de entrada.';

    FocusNode forgotPasswordEmailFocusNode = FocusNode();

    FocusNode forgotPasswordCtaFocusNode = FocusNode(
      skipTraversal: true,
    );

    return Padding(
      padding: EdgeInsets.all(uiConstants.paddingExtraLarge),
      child: FocusScope(
        child: Consumer<Session>(builder: (context, session, child) {
          return Form(
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
                    return inputValidators
                        .forgotPasswordInputEmailValidator(value);
                  },
                  onEditingComplete: () {
                    forgotPasswordEmailFocusNode.unfocus();
                    forgotPasswordCtaFocusNode.requestFocus();
                  },
                  onTapOutside: ((event) =>
                      forgotPasswordEmailFocusNode.unfocus()),
                  focusNode: forgotPasswordEmailFocusNode,
                ),
                SizedBox(
                  height: uiConstants.paddingExtraExtraLarge,
                ),
                FilledButton(
                  onPressed: () {
                    if (_forgotPasswordFormKey.currentState!.validate()) {
                      session
                          .requestPasswordReset(
                              email: _forgotPasswordEmailController.text)
                          .then(
                        (value) {
                          if (value == null) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(recoveryMessage),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(value),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
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
                SizedBox(
                  height: uiConstants.paddingSmall,
                ),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: true,
                      useSafeArea: true,
                      useRootNavigator: true,
                      showDragHandle: true,
                      isScrollControlled: true,
                      enableDrag: true,
                      builder: ((BuildContext context) {
                        return const Center();
                      }),
                    );
                  },
                  child: Text(
                    helperPasswordButtonText,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: uiConstants.paddingExtraSmall,
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
          );
        }),
      ),
    );
  }
}
