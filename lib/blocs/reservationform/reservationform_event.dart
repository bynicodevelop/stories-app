import 'package:equatable/equatable.dart';

abstract class ReservationformEvent extends Equatable {
  const ReservationformEvent();

  @override
  List<Object> get props => [];
}

class UsernameFormChanged extends ReservationformEvent {
  final String username;

  const UsernameFormChanged({
    this.username,
  });

  @override
  List<Object> get props => [username];
}

class SlugFormChanged extends ReservationformEvent {
  final String slug;

  const SlugFormChanged({
    this.slug,
  });

  @override
  List<Object> get props => [slug];
}

class PhoneNumberFormChanged extends ReservationformEvent {
  final String phoneNumber;

  const PhoneNumberFormChanged({
    this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class FormSubmitted extends ReservationformEvent {}

class SubmissionFailure extends ReservationformEvent {}
