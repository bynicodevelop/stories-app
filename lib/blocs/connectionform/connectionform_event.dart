import 'package:equatable/equatable.dart';

abstract class ConnectionFormEvent extends Equatable {
  const ConnectionFormEvent();

  @override
  List<Object> get props => [];
}

class ConnectionPasswordFormUpdated extends ConnectionFormEvent {
  final String password;

  const ConnectionPasswordFormUpdated({
    this.password,
  });

  @override
  List<Object> get props => [password];
}

class ConnectionPhoneNumberFormUpdated extends ConnectionFormEvent {
  final String phoneNumber;

  const ConnectionPhoneNumberFormUpdated({
    this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class ConnectionEmailFormUpdated extends ConnectionFormEvent {
  final String email;

  const ConnectionEmailFormUpdated({
    this.email,
  });

  @override
  List<Object> get props => [email];
}

class ConnectionFormSubmitted extends ConnectionFormEvent {}
