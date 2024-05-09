import '../../../common_libs.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _passwordLoginController =
      TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const String title = 'Entre com seu email e senha';
    const String forgotPasswordButtonText = 'Esqueceu a senha?';
    const String ctaButtonText = 'Entrar';
    const String helperRegisterButtonText = 'Ainda não tem cadastro?';
    const String registerButtonText = 'Crie uma conta gratuitamente';
    const String hintTextEmail = 'Email';
    const String hintTextPassword = 'Senha';
    const String emailLoginInputKey = 'email-login-input-key';
    const String emailPasswordInputKey = 'password-login-input-key';
    const String goToStoreText = 'Ir para a loja';
    const String loggingText = 'Entrando';

    FocusNode emailFocusNode = FocusNode();
    FocusNode passwordFocusNode = FocusNode();
    FocusNode ctaFocusNode = FocusNode(skipTraversal: true);

    return Padding(
      padding: EdgeInsets.all(uiConstants.paddingExtraLarge),
      child: FocusScope(
        child: Consumer<Session>(builder: (context, session, child) {
          return Form(
            key: _loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: uiConstants.paddingExtraExtraLarge),
                TextFormField(
                  key: const Key(emailLoginInputKey),
                  controller: _emailLoginController,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  decoration: const InputDecoration(hintText: hintTextEmail),
                  validator: (String? value) {
                    return inputValidators.emailLoginValidator(value);
                  },
                  onEditingComplete: () {
                    emailFocusNode.unfocus();
                    passwordFocusNode.requestFocus();
                  },
                  onTapOutside: (event) => emailFocusNode.unfocus(),
                  focusNode: emailFocusNode,
                ),
                SizedBox(height: uiConstants.paddingExtraLarge),
                TextFormField(
                  key: const Key(emailPasswordInputKey),
                  controller: _passwordLoginController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  autofillHints: const [AutofillHints.password],
                  decoration: const InputDecoration(hintText: hintTextPassword),
                  validator: (String? value) {
                    return inputValidators.passwordLoginValidator(value);
                  },
                  onEditingComplete: () {
                    passwordFocusNode.unfocus();
                    ctaFocusNode.requestFocus();
                    _loginFormKey.currentState!.validate();
                  },
                  onTapOutside: (event) => passwordFocusNode.unfocus(),
                  focusNode: passwordFocusNode,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      appRouter.push(ScreenPaths.forgotPassword);
                    },
                    child: Text(
                      forgotPasswordButtonText,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                SizedBox(height: uiConstants.paddingExtraLarge),
                FilledButton(
                  onPressed:
                      _isLoading ? null : () => _userLogin(session, context),
                  focusNode: ctaFocusNode,
                  child: _isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: uiConstants
                                  .smallCircularProgressIndicatorSize,
                              width: uiConstants
                                  .smallCircularProgressIndicatorSize,
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    uiConstants.backgroundLight,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: uiConstants.paddingMedium),
                            const Text(loggingText),
                          ],
                        )
                      : const Text(ctaButtonText),
                ),
                SizedBox(height: uiConstants.paddingExtraLarge),
                Text(
                  helperRegisterButtonText,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {
                    appRouter.push(ScreenPaths.register);
                  },
                  child: Text(
                    registerButtonText,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                SizedBox(height: uiConstants.paddingMedium),
                TextButton.icon(
                  onPressed: () {
                    appRouter.go(ScreenPaths.home);
                  },
                  label: Text(
                    goToStoreText,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  icon: const Icon(Icons.shopping_basket_sharp),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _userLogin(Session session, BuildContext context) {
    if (_loginFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      session
          .login(
        email: _emailLoginController.text,
        password: _passwordLoginController.text,
      )
          .then((value) {
        if (value == null) {
          appRouter.go(ScreenPaths.home);
        } else {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(value),
              backgroundColor: uiConstants.errorLight,
            ),
          );
        }
      }).whenComplete(() {
        setState(() {
          Future.delayed(const Duration(seconds: 1), () {
            _isLoading = false;
          });
        });
      });
    }
  }
}
