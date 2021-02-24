import 'package:formz/formz.dart';

enum UsernameInputError { empty }

class Username extends FormzInput<String, UsernameInputError> {
  const Username.pure([String value = '']) : super.pure(value);

  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameInputError validator(String value) =>
      value?.isNotEmpty == true ? null : UsernameInputError.empty;
}
