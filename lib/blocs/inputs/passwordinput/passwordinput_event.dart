import 'package:equatable/equatable.dart';

abstract class PasswordInputEvent extends Equatable {
  const PasswordInputEvent();

  @override
  List<Object> get props => [];
}

class PasswordChanged extends PasswordInputEvent {
  final String password;

  const PasswordChanged({
    this.password,
  });

  @override
  List<Object> get props => [password];
}
