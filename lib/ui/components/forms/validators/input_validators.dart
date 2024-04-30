import 'package:camilo/common_libs.dart';

class InputValidators with ChangeNotifier {
  get emailLoginValidator => _emailLoginValidator;

  get passwordLoginValidator => _passwordLoginValidator;

  get nameRegisterValidator => _nameRegisterValidator;

  get emailRegisterValidator => _emailRegisterValidator;

  get firstPasswordRegisterValidator => _firstPasswordRegisterValidator;

  get secondPasswordRegisterValidator => _secondPasswordRegisterValidator;

  get forgotPasswordInputEmailValidator => _forgotPasswordInputEmailValidator;

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

  _nameRegisterValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe um nome válido';
    } else {
      return null;
    }
  }

  _emailRegisterValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe um e-mail válido';
    } else if (!value.contains('@')) {
      return 'Informe um e-mail válido';
    } else {
      return null;
    }
  }

  _firstPasswordRegisterValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe uma senha válida';
    } else if (value.length < 6) {
      return 'Senha muito curta';
    } else {
      return null;
    }
  }

  _secondPasswordRegisterValidator(String? value, String firstPassword) {
    if (value == null || value.isEmpty) {
      return 'Informe uma senha válida';
    } else if (value.length < 6) {
      return 'Senha muito curta';
    } else if (value != firstPassword) {
      return 'As senhas não coincidem';
    } else {
      return null;
    }
  }

  _forgotPasswordInputEmailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe um e-mail válido';
    } else if (!value.contains('@')) {
      return 'Informe um e-mail válido';
    } else {
      return null;
    }
  }
}
