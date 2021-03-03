import 'package:equatable/equatable.dart';

abstract class EmailInputEvent extends Equatable {
  const EmailInputEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends EmailInputEvent {
  final String email;

  const EmailChanged({
    this.email,
  });

  @override
  List<Object> get props => [email];
}
