import 'package:equatable/equatable.dart';

abstract class ReservationformEvent extends Equatable {
  const ReservationformEvent();

  @override
  List<Object> get props => [];
}

class UsernameChanged extends ReservationformEvent {
  final String username;

  const UsernameChanged({
    this.username,
  });

  @override
  List<Object> get props => [username];
}

class SlugChanged extends ReservationformEvent {
  final String slug;

  const SlugChanged({
    this.slug,
  });

  @override
  List<Object> get props => [slug];
}

class PhoneNumberChanged extends ReservationformEvent {
  final String phoneNumber;

  const PhoneNumberChanged({
    this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class FormSubmitted extends ReservationformEvent {}
