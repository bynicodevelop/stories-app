import 'package:formz/formz.dart';

enum EmailInputError { empty, invalid }

class Email extends FormzInput<String, EmailInputError> {
  const Email.pure([String value = '']) : super.pure(value);

  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailInputError validator(String value) {
    if (value?.isEmpty == true) {
      return EmailInputError.empty;
    }

    if (!_emailRegExp.hasMatch(value)) {
      return EmailInputError.invalid;
    }

    return null;
  }
}
