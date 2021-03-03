import 'dart:async';

import 'package:app/blocs/inputs/passwordinput/bloc.dart';
import 'package:app/formModels/Password.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

class PasswordInputBloc extends Bloc<PasswordInputEvent, PasswordInputState> {
  PasswordInputBloc() : super(PasswordInputState());

  @override
  Stream<PasswordInputState> mapEventToState(
    PasswordInputEvent event,
  ) async* {
    if (event is PasswordChanged) {
      Password password = Password.dirty(event.password);

      yield state.copyWith(
        password: password.valid ? password : Password.pure(event.password),
        status: Formz.validate([password]),
      );
    }
  }
}
