import 'dart:async';

import 'package:app/blocs/usernameinput/bloc.dart';
import 'package:app/formModels/Username.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

class UsernameInputBloc extends Bloc<UsernameInputEvent, UsernameInputState> {
  UsernameInputBloc() : super(UsernameInputState());

  @override
  Stream<UsernameInputState> mapEventToState(
    UsernameInputEvent event,
  ) async* {
    if (event is UsernameChanged) {
      Username username = Username.dirty(event.username);

      yield state.copyWith(
        username: username.valid ? username : Username.pure(event.username),
        status: Formz.validate([username]),
      );
    }
  }
}
