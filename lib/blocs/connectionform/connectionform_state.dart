import 'package:app/formModels/Email.dart';
import 'package:app/formModels/Password.dart';
import 'package:app/formModels/PhoneNumber.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class ConnectionFormState extends Equatable {
  final Password password;
  final Email email;
  final PhoneNumber phoneNumber;
  final FormzStatus status;

  const ConnectionFormState({
    this.password = const Password.pure(),
    this.email = const Email.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.status = FormzStatus.pure,
  });

  ConnectionFormState copyWith({
    Password password,
    PhoneNumber phoneNumber,
    Email email,
    FormzStatus status,
  }) {
    return ConnectionFormState(
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [password, status, phoneNumber];
}
