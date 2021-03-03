import 'package:app/formModels/Username.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class UsernameInputState extends Equatable {
  final Username username;
  final FormzStatus status;

  const UsernameInputState({
    this.username = const Username.pure(),
    this.status = FormzStatus.pure,
  });

  UsernameInputState copyWith({
    Username username,
    FormzStatus status,
  }) {
    return UsernameInputState(
      username: username ?? this.username,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        username,
        status,
      ];
}
