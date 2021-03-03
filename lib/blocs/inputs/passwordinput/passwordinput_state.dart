import 'package:app/formModels/Password.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class PasswordInputState extends Equatable {
  final Password password;
  final FormzStatus status;

  const PasswordInputState({
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  PasswordInputState copyWith({
    Password password,
    FormzStatus status,
  }) {
    return PasswordInputState(
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        password,
        status,
      ];
}
