import 'dart:async';

import 'package:app/blocs/reservationform/bloc.dart';
import 'package:app/formModels/PhoneNumber.dart';
import 'package:app/formModels/Slug.dart';
import 'package:app/formModels/Username.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

class ReservationformBloc
    extends Bloc<ReservationformEvent, ReservationformState> {
  ReservationformBloc() : super(ReservationformState());

  @override
  Stream<ReservationformState> mapEventToState(
    ReservationformEvent event,
  ) async* {
    if (event is UsernameChanged) {
      final username = Username.dirty(event.username);

      yield state.copyWith(
        username: username.valid ? username : Username.pure(event.username),
        status: Formz.validate([username, state.slug, state.phoneNumber]),
      );
    } else if (event is SlugChanged) {
      final slug = Slug.dirty(event.slug);
      print(event);
      yield state.copyWith(
        slug: slug.valid ? slug : Slug.pure(event.slug),
        status: Formz.validate([slug, state.username, state.phoneNumber]),
      );
    } else if (event is PhoneNumberChanged) {
      final phoneNumber = PhoneNumber.dirty(event.phoneNumber);

      yield state.copyWith(
          phoneNumber: phoneNumber.valid
              ? phoneNumber
              : PhoneNumber.dirty(event.phoneNumber),
          status: Formz.validate([phoneNumber, state.slug, state.username]));
    } else if (event is FormSubmitted) {
      final username = Username.dirty(state.username.value);
      final slug = Slug.dirty(state.slug.value);
      final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);

      yield state.copyWith(
        username: username,
        slug: slug,
        phoneNumber: phoneNumber,
        status: Formz.validate([username, slug, phoneNumber]),
      );

      if (state.status.isValidated) {
        yield state.copyWith(
          status: FormzStatus.submissionInProgress,
        );
        //   await Future<void>.delayed(const Duration(seconds: 1));
        //   yield state.copyWith(
        //     status: FormzStatus.submissionSuccess,
        //   );
      }
    }
  }
}