import 'dart:async';

import 'package:app/blocs/connectionform/bloc.dart';
import 'package:app/formModels/Email.dart';
import 'package:app/formModels/Password.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

class ConnectionFormBloc
    extends Bloc<ConnectionFormEvent, ConnectionFormState> {
  ConnectionFormBloc() : super(ConnectionFormState());

  @override
  Stream<ConnectionFormState> mapEventToState(
    ConnectionFormEvent event,
  ) async* {
    if (event is ConnectionPasswordFormUpdated) {
      Password password = Password.dirty(event.password);

      yield state.copyWith(
        password: password.valid ? password : Password.pure(event.password),
        status: Formz.validate([password, state.email]),
      );
    } else if (event is ConnectionEmailFormUpdated) {
      Email email = Email.dirty(event.email);

      yield state.copyWith(
        email: email.valid ? email : Password.pure(event.email),
        status: Formz.validate([email, state.password]),
      );
    } else if (event is ConnectionFormSubmitted) {
      final Email email = Email.dirty(state.email.value);
      final Password password = Password.dirty(state.password.value);

      yield state.copyWith(
        password: password,
        email: email,
      );

      if (state.status.isValidated) {
        yield state.copyWith(
          status: FormzStatus.submissionInProgress,
        );
      }
    }
  }
}
