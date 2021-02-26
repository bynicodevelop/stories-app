import 'package:app/formModels/Email.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class EmailInputState extends Equatable {
  final Email email;
  final FormzStatus status;

  const EmailInputState({
    this.email = const Email.pure(),
    this.status = FormzStatus.pure,
  });

  EmailInputState copyWith({
    Email email,
    FormzStatus status,
  }) {
    return EmailInputState(
      email: email ?? this.email,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        email,
        status,
      ];
}
