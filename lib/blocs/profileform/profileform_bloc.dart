import 'dart:async';

import 'package:app/blocs/profileform/bloc.dart';
import 'package:app/formModels/Email.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

class ProfileFormBloc extends Bloc<ProfileFormEvent, ProfileFormState> {
  ProfileFormBloc() : super(ProfileFormState());

  @override
  Stream<ProfileFormState> mapEventToState(
    ProfileFormEvent event,
  ) async* {
    if (event is EmailProfileUpdated) {
      Email email = Email.dirty(event.email);

      yield state.copyWith(
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate([email]),
      );
    } else if (event is ProfileFormSubmitted) {
      Email email = Email.dirty(state.email.value);

      // yield state.copyWith(
      //   email: email,
      // );

      if (state.status.isValidated) {
        yield state.copyWith(
          status: FormzStatus.submissionInProgress,
        );
      } else {
        yield state.copyWith(
          email: email.valid ? email : Email.pure(state.email.value),
          status: FormzStatus.invalid,
        );
      }
    }
  }
}
