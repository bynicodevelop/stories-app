import 'package:equatable/equatable.dart';

abstract class ProfileFormEvent extends Equatable {
  const ProfileFormEvent();

  @override
  List<Object> get props => [];
}

class EmailProfileUpdated extends ProfileFormEvent {
  final String email;

  const EmailProfileUpdated({this.email});
}

class ProfileFormSubmitted extends ProfileFormEvent {}

class ProfileFormUpdatedWithSucess extends ProfileFormEvent {}

class ProfileFormUpdatedWithError extends ProfileFormEvent {}
