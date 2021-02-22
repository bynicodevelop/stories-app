import 'package:formz/formz.dart';

enum PhoneNumberInputError { empty, invalid, tooshort }

class PhoneNumber extends FormzInput<String, PhoneNumberInputError> {
  const PhoneNumber.pure([String value = '']) : super.pure(value);

  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final _phoneNumberRegex = RegExp(
    r'^\+[0-9]{10}',
  );

  @override
  PhoneNumberInputError validator(String value) {
    if (value?.isEmpty == true) {
      return PhoneNumberInputError.empty;
    }

    // TODO: Peut générer des erreurs pour les numéros autre que français
    if (value.length <= 11 || value.length > 12) {
      return PhoneNumberInputError.tooshort;
    }

    if (_phoneNumberRegex.hasMatch(value) == false) {
      return PhoneNumberInputError.invalid;
    }

    return null;
  }
}
