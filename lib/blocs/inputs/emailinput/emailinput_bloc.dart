import 'dart:async';

import 'package:app/blocs/inputs/emailinput/bloc.dart';
import 'package:app/formModels/Email.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

class EmailInputBloc extends Bloc<EmailInputEvent, EmailInputState> {
  EmailInputBloc() : super(EmailInputState());

  @override
  Stream<EmailInputState> mapEventToState(
    EmailInputEvent event,
  ) async* {
    if (event is EmailChanged) {
      Email email = Email.dirty(event.email);

      yield state.copyWith(
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate([email]),
      );
    }
  }
}
