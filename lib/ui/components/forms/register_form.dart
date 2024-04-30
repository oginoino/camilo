import '../../../common_libs.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({super.key});

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  final TextEditingController _registerEmailController =
      TextEditingController();

  final TextEditingController _registerNameInputController =
      TextEditingController();

  final TextEditingController _firstPasswordRegisterController =
      TextEditingController();

  final TextEditingController _secondPasswordRegisterController =
      TextEditingController();

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
    return Padding(
      padding: EdgeInsets.all(uiConstants.paddingExtraLarge),
      child: Form(
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
            SizedBox(
              height: uiConstants.paddingExtraExtraLarge,
            ),
            TextFormField(
              key: const Key(nameRegisterFormKey),
              controller: _registerNameInputController,
              keyboardType: TextInputType.name,
              autofillHints: const [AutofillHints.name],
              decoration: const InputDecoration(
                hintText: nameRegisterHintText,
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
            SizedBox(
              height: uiConstants.paddingExtraLarge,
            ),
            TextFormField(
              key: const Key(emailRegisterInputKey),
              controller: _registerEmailController,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              decoration: const InputDecoration(
                hintText: emailRegisterHintText,
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
              height: 32,
            ),
            TextFormField(
              key: const Key(firstPasswordRegisterInputKey),
              controller: _firstPasswordRegisterController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              autofillHints: const [AutofillHints.password],
              decoration: const InputDecoration(
                hintText: firstPasswordRegisterHintText,
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
            SizedBox(
              height: uiConstants.paddingExtraLarge,
            ),
            TextFormField(
              controller: _secondPasswordRegisterController,
              key: const Key(secondPasswordRegisterInputKey),
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              autofillHints: const [AutofillHints.password],
              decoration: const InputDecoration(
                hintText: secondPasswordRegisterHintText,
              ),
              validator: (String? value) {
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
              },
            ),
            SizedBox(
              height: uiConstants.paddingExtraExtraLarge,
            ),
            FilledButton(
              onPressed: () {},
              child: const Text(ctaButtonText),
            ),
            SizedBox(
              height: uiConstants.paddingLarge,
            ),
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
                    builder: ((BuildContext context) {
                      return const Center();
                    }));
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
                SizedBox(
                  width: uiConstants.paddingSmall,
                ),
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
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
