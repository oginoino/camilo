import '../../../common_libs.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  final String _emailLoginInputKey = 'email-login-input-key';

  final String _emailPasswordInputKey = 'password-login-input-key';

  final TextEditingController _emailLoginController = TextEditingController();

  final TextEditingController _passwordLoginController =
      TextEditingController();

  final String title = 'Entre com seu email e senha';

  final String forgotPasswordButtonText = 'Esqueceu a senha?';

  final String ctaButtonText = 'Entrar';

  final String helperRegisterButtonText = 'Ainda não tem cadastro?';

  final String registerButtonText = 'Crie uma conta gratuitamente';

  @override
  Widget build(BuildContext context) {
    const String hintTextEmail = 'Email';
    const String hintTextPassword = 'Senha';
    FocusNode emailFocusNode = FocusNode();
    FocusNode passwordFocusNode = FocusNode();
    return Padding(
      padding: EdgeInsets.all(uiConstants.paddingExtraLarge),
      child: FocusScope(
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: uiConstants.paddingExtraExtraLarge,
              ),
              TextFormField(
                key: Key(_emailLoginInputKey),
                controller: _emailLoginController,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                decoration: const InputDecoration(
                  hintText: hintTextEmail,
                ),
                validator: (String? value) {
                  return null;
                },
                onEditingComplete: () {
                  emailFocusNode.unfocus();
                  passwordFocusNode.requestFocus();
                },
                onTapOutside: ((event) => emailFocusNode.unfocus()),
                focusNode: emailFocusNode,
              ),
              SizedBox(
                height: uiConstants.paddingExtraLarge,
              ),
              TextFormField(
                key: Key(_emailPasswordInputKey),
                controller: _passwordLoginController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const [AutofillHints.password],
                decoration: const InputDecoration(
                  hintText: hintTextPassword,
                ),
                validator: (String? value) {
                  return null;
                },
                onEditingComplete: () {
                  passwordFocusNode.unfocus();
                },
                onTapOutside: ((event) => passwordFocusNode.unfocus()),
                focusNode: passwordFocusNode,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    forgotPasswordButtonText,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: uiConstants.paddingExtraLarge,
              ),
              FilledButton(
                onPressed: () {},
                child: Text(ctaButtonText),
              ),
              SizedBox(
                height: uiConstants.paddingExtraLarge,
              ),
              Text(
                helperRegisterButtonText,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () {},
                child: Text(registerButtonText,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.w600,
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
