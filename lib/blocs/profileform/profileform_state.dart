import 'package:app/formModels/Email.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class ProfileFormState extends Equatable {
  final Email email;
  final FormzStatus status;

  const ProfileFormState({
    this.email: const Email.pure(),
    this.status: FormzStatus.pure,
  });

  ProfileFormState copyWith({
    Email email,
    FormzStatus status,
  }) {
    return ProfileFormState(
      email: email ?? this.email,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, status];
}
