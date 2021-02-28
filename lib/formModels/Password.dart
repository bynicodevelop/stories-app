import 'package:formz/formz.dart';

enum PasswordInputError { empty, tooshort }

class Password extends FormzInput<String, PasswordInputError> {
  const Password.pure([String value = '']) : super.pure(value);

  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordInputError validator(String value) {
    if (value?.isEmpty == true) {
      return PasswordInputError.empty;
    }

    // // TODO: Peut générer des erreurs pour les numéros autre que français
    if (value.length < 6) {
      return PasswordInputError.tooshort;
    }

    return null;
  }
}
