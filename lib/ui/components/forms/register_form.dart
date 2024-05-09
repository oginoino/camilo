import '../../../common_libs.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _registerEmailController =
      TextEditingController();
  final TextEditingController _registerNameInputController =
      TextEditingController();
  final TextEditingController _firstPasswordRegisterController =
      TextEditingController();
  final TextEditingController _secondPasswordRegisterController =
      TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const String title = 'Crie uma conta gratuitamente';
    const String ctaButtonText = 'Cadastrar';
    const String helperTerms = 'Ao se cadastrar, você concorda com nossos';
    const String termsButtonText = 'Termos de uso e política de privacidade';
    const String helperLogin = 'Já possui cadastro?';
    const String helperLoginText = 'Faça login';
    const String nameRegisterFormKey = 'name-register-input-key';
    const String emailRegisterInputKey = 'email-register-input-key';
    const String firstPasswordRegisterInputKey =
        'first-password-register-input-key';
    const String secondPasswordRegisterInputKey =
        'second-password-register-key';
    const String nameRegisterHintText = 'Qual o seu nome?';
    const String emailRegisterHintText = 'Seu melhor email';
    const String firstPasswordRegisterHintText = 'Crie uma senha forte';
    const String secondPasswordRegisterHintText = 'Confirme a sua senha';
    const String registeringText = 'Cadastrando';

    FocusNode nameRegisterFocusNode = FocusNode();
    FocusNode emailRegisterFocusNode = FocusNode();
    FocusNode firstPasswordRegisterFocusNode = FocusNode();
    FocusNode secondPasswordRegisterFocusNode = FocusNode();
    FocusNode ctaFocusNode = FocusNode(skipTraversal: true);

    return Padding(
      padding: EdgeInsets.all(uiConstants.paddingExtraLarge),
      child: FocusScope(
        child: Consumer<Session>(builder: (context, session, child) {
          return Form(
            key: _registerFormKey,
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
                SizedBox(height: uiConstants.paddingExtraExtraLarge),
                TextFormField(
                  key: const Key(nameRegisterFormKey),
                  controller: _registerNameInputController,
                  keyboardType: TextInputType.name,
                  autofillHints: const [AutofillHints.name],
                  decoration:
                      const InputDecoration(hintText: nameRegisterHintText),
                  validator: (String? value) {
                    return inputValidators.nameRegisterValidator(value);
                  },
                  onEditingComplete: () {
                    nameRegisterFocusNode.unfocus();
                    emailRegisterFocusNode.requestFocus();
                  },
                  onTapOutside: (event) => nameRegisterFocusNode.unfocus(),
                  focusNode: nameRegisterFocusNode,
                ),
                SizedBox(height: uiConstants.paddingExtraLarge),
                TextFormField(
                  key: const Key(emailRegisterInputKey),
                  controller: _registerEmailController,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  decoration:
                      const InputDecoration(hintText: emailRegisterHintText),
                  validator: (String? value) {
                    return inputValidators.emailRegisterValidator(value);
                  },
                  onEditingComplete: () {
                    emailRegisterFocusNode.unfocus();
                    firstPasswordRegisterFocusNode.requestFocus();
                  },
                  onTapOutside: (event) => emailRegisterFocusNode.unfocus(),
                  focusNode: emailRegisterFocusNode,
                ),
                SizedBox(height: uiConstants.paddingExtraLarge),
                TextFormField(
                  key: const Key(firstPasswordRegisterInputKey),
                  controller: _firstPasswordRegisterController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  autofillHints: const [AutofillHints.password],
                  decoration: const InputDecoration(
                      hintText: firstPasswordRegisterHintText),
                  validator: (String? value) {
                    return inputValidators
                        .firstPasswordRegisterValidator(value);
                  },
                  onEditingComplete: () {
                    firstPasswordRegisterFocusNode.unfocus();
                    secondPasswordRegisterFocusNode.requestFocus();
                  },
                  onTapOutside: (event) =>
                      firstPasswordRegisterFocusNode.unfocus(),
                  focusNode: firstPasswordRegisterFocusNode,
                ),
                SizedBox(height: uiConstants.paddingExtraLarge),
                TextFormField(
                  key: const Key(secondPasswordRegisterInputKey),
                  controller: _secondPasswordRegisterController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  autofillHints: const [AutofillHints.password],
                  decoration: const InputDecoration(
                      hintText: secondPasswordRegisterHintText),
                  validator: (String? value) {
                    return inputValidators.secondPasswordRegisterValidator(
                        value, _firstPasswordRegisterController.text);
                  },
                  onEditingComplete: () {
                    secondPasswordRegisterFocusNode.unfocus();
                    ctaFocusNode.requestFocus();
                    _registerFormKey.currentState!.validate();
                  },
                  onTapOutside: (event) =>
                      secondPasswordRegisterFocusNode.unfocus(),
                  focusNode: secondPasswordRegisterFocusNode,
                ),
                SizedBox(height: uiConstants.paddingExtraExtraLarge),
                FilledButton(
                  onPressed:
                      _isLoading ? null : () => _userRegister(session, context),
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
                            const Text(registeringText),
                          ],
                        )
                      : const Text(ctaButtonText),
                ),
                SizedBox(height: uiConstants.paddingLarge),
                Text(
                  helperTerms,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  textAlign: TextAlign.center,
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
                      builder: (BuildContext context) {
                        return const Center();
                      },
                    );
                  },
                  child: Text(
                    termsButtonText,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.w600,
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
                    SizedBox(width: uiConstants.paddingSmall),
                    TextButton(
                      onPressed: () {
                        appRouter.canPop()
                            ? appRouter.pop()
                            : appRouter.go(ScreenPaths.login);
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

  void _userRegister(Session session, BuildContext context) {
    if (_registerFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      session
          .register(
        name: _registerNameInputController.text,
        email: _registerEmailController.text,
        password: _firstPasswordRegisterController.text,
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
          _isLoading = false;
        });
      });
    }
  }
}
