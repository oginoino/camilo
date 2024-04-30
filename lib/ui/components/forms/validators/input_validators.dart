import 'package:camilo/common_libs.dart';

class InputValidators with ChangeNotifier {
  get emailLoginValidator => _emailLoginValidator;

  get passwordLoginValidator => _passwordLoginValidator;

  _emailLoginValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe um e-mail válido';
    } else if (!value.contains('@')) {
      return 'Informe um e-mail válido';
    } else {
      return null;
    }
  }

  _passwordLoginValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe uma senha válida';
    } else if (value.length < 6) {
      return 'Senha muito curta';
    } else {
      return null;
    }
  }
}
