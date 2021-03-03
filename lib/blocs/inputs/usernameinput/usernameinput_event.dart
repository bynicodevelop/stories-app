import 'package:equatable/equatable.dart';

abstract class UsernameInputEvent extends Equatable {
  const UsernameInputEvent();

  @override
  List<Object> get props => [];
}

class UsernameChanged extends UsernameInputEvent {
  final String username;

  const UsernameChanged({
    this.username,
  });

  @override
  List<Object> get props => [username];
}
