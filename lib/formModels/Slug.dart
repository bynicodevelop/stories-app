import 'package:formz/formz.dart';

enum SlugInputError { empty, invalid }

class Slug extends FormzInput<String, SlugInputError> {
  const Slug.pure([String value = '']) : super.pure(value);

  const Slug.dirty([String value = '']) : super.dirty(value);

  static final _slugRegex = RegExp(
    r'[A-Z ]',
  );

  @override
  SlugInputError validator(String value) {
    if (value?.isEmpty == true) {
      return SlugInputError.empty;
    }

    if (_slugRegex.hasMatch(value) == true) {
      return SlugInputError.invalid;
    }

    return null;
  }
}
